/* 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <avr/io.h>
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include <util/delay.h>
#include "usb_serial.h"

#define CPU_PRESCALE(n) (CLKPR = 0x80, CLKPR = (n))

void send_str(const char *s);
uint8_t recv_str(char *buf, uint8_t size);
void parse_and_execute_command(const char *buf, uint8_t num);

static const uint16_t icr_val = 40000;
static const uint16_t min_ocr = 2000;
static const uint8_t min_ocrl = 0xD0;
static const uint8_t min_ocrh = 0x07;
static const uint16_t max_ocr = 4000;
static const uint8_t max_ocrl = 0xA0;
static const uint8_t max_ocrh = 0x0F;

void set_default_duty_cycles(void)
{
	OCR1AH = 0;
	OCR1AL = 0;

	OCR1BH = 0;
	OCR1BL = 0;

	OCR1CH = 0;
	OCR1CL = 0;

	OCR3AH = 0;
	OCR3AL = 0;
}

void setup_pwms(void)
{
    /* 16Mhz / 8 / 40000 = 50hz */
	ICR1 = icr_val;
	ICR3 = icr_val;

    /* Set OC1[A|B|C] to low on match, set high at TOP also set part of mode 14. */
	TCCR1A = (1<<COM1A1) | (1<<COM1B1) | (1<<COM1C1) | (1<<WGM11);
    /* Prescale factor of 8 and complete setting of PWM mode 14. */
	TCCR1B = (1<<CS11) | (1<<WGM12) | (1<<WGM13);

    /* Set OC3A to low on match, set high at TOP also set part of mode 14. */
	TCCR3A = (1<<COM3A1) | (1<<WGM31);
    /* Prescale factor of 8 and complete setting of PWM mode 14. */
	TCCR3B = (1<<CS31) | (1<<WGM32) | (1<<WGM33);

    /* Set initial PWM duties to 0% */
	OCR1AH = 0;
	OCR1AL = 0;

	OCR1BH = 0;
	OCR1BL = 0;

	OCR1CH = 0;
	OCR1CL = 0;

	OCR3AH = 0;
	OCR3AL = 0;

    /* Set initial counters to 0. Interrupts should be off. */
	TCNT1 = 0;
	TCNT3 = 0;

	// Timer 1 and Timer 3
	// Set ports to output
	DDRB |= (1 << DDB5) | (1 << DDB6) | (1 << DDB7);
    DDRC |= (1 << DDC6);
}

void handle_query_pwm_command(uint8_t port)
{
	// TODO
}

/**
 * @breif Handle a set pwm command
 */
void handle_set_pwm_command(uint8_t port, uint8_t vall, uint8_t valh)
{
    /* TODO: verify new duty cycle is within valid range. */
    if( (valh < min_ocrh && vall < min_ocrl) || (valh > max_ocrh && vall > max_ocrl) ){
	    send_str(PSTR("Invalid PWM value. Must be between 2000 and 4000 (inclusive).\n"));
        return;
    }

	usb_serial_putchar('\x04');
	usb_serial_putchar(port);

	switch(port)
	{
		case 0:
			OCR1AH = valh;
			OCR1AL = vall;
			break;
		case 1:
			OCR1BH = valh;
			OCR1BL = vall;
			break;
		case 2:
			OCR1CH = valh;
			OCR1CL = vall;
			break;
		case 3:
			OCR3AH = valh;
			OCR3AL = vall;
			break;
	}

	usb_serial_putchar('\x00');
	usb_serial_putchar('\n');
}

void handle_version_command(void)
{
	usb_serial_putchar('\x00');
	send_str(PSTR("ESC Controller 1.0\n"));
}

void handle_ping_command(const char *str, uint8_t len)
{
	const char *data_itr;
	uint8_t ndx = 1;

	data_itr = str;

	usb_serial_putchar('\x02');
	while(ndx < len)
	{
		usb_serial_putchar(data_itr[ndx]);
		++ndx;
	}
	usb_serial_putchar('\n');
}

void handle_pwm_ports_command(void)
{
	usb_serial_putchar('\x03');
	usb_serial_putchar('\x00');
	send_str(PSTR("\x01\x02\x03\x04\x05\x06\x07\x08\n"));
}

void handle_arm_esc_command(uint8_t port)
{
    switch(port)
    {
        case 0:
            OCR1A = min_ocr;
	        _delay_ms(1000);
            break;
        case 1:
            OCR1B = min_ocr;
	        _delay_ms(1000);
            break;
        case 2:
            OCR1C = min_ocr;
	        _delay_ms(1000);
            break;
        case 3:
            OCR3A = min_ocr;
	        _delay_ms(1000);
            break;
        case 4:
            OCR1A = min_ocr;
            OCR1B = min_ocr;
            OCR1C = min_ocr;
            OCR3A = min_ocr;
	        _delay_ms(1000);
            break;
    }
}

void handle_command(const char *str, uint8_t len)
{
	if(len == 0)
		return;

	switch(str[0])
	{
		case 0:
			handle_version_command();
			break;
		case 1:
			handle_ping_command(str, len);
			break;
		case 3:
			handle_pwm_ports_command();
			break;
		case 4:
			handle_set_pwm_command(str[1], str[2], str[3]);
			break;
		case 5:
			handle_query_pwm_command(str[1]);
			break;
		case 6:
			handle_arm_esc_command(str[1]);
			break;
		default:
			send_str(PSTR("INVALID_COMMAND_CODE"));
	}
}

int main(void)
{
	char buf[32];
	uint8_t n;

	CPU_PRESCALE(0);
	setup_pwms();

	usb_init();
	while (!usb_configured()) /* wait */ ;
	_delay_ms(1000);

	while (1){
		while (!(usb_serial_get_control() & USB_SERIAL_DTR)) /* wait */ ;
		usb_serial_flush_input();

		while (1) {
			n = recv_str(buf, sizeof(buf));
			if (n == 255) break;
			handle_command(buf, n);
		}
	}

}

// Send a string to the USB serial port.  The string must be in
// flash memory, using PSTR
//
void send_str(const char *s)
{
	char c;
	while (1) {
		c = pgm_read_byte(s++);
		if (!c) break;
		usb_serial_putchar(c);
	}
}

// Receive a string from the USB serial port.  The string is stored
// in the buffer and this function will not exceed the buffer size.
// A carriage return or newline completes the string, and is not
// stored into the buffer.
// The return value is the number of characters received, or 255 if
// the virtual serial connection was closed while waiting.
//
uint8_t recv_str(char *buf, uint8_t size)
{
	int16_t r;
	uint8_t count=0;

	while (count < size) {
		r = usb_serial_getchar();
		if (r != -1) {
			if (r == '\r' || r == '\n') return count;
			*buf++ = r;
			//usb_serial_putchar(r);
			count++;
		} else {
			if (!usb_configured() ||
			  !(usb_serial_get_control() & USB_SERIAL_DTR)) {
				// user no longer connected
				return 255;
			}
			// just a normal timeout, keep waiting
		}
	}
	return count;
}

// parse a user command and execute it, or print an error message
//
void parse_and_execute_command(const char *buf, uint8_t num)
{
	uint8_t port, pin, val;

	if (num < 3) {
		send_str(PSTR("unrecognized format, 3 chars min req'd\r\n"));
		return;
	}
	// first character is the port letter
	if (buf[0] >= 'A' && buf[0] <= 'F') {
		port = buf[0] - 'A';
	} else if (buf[0] >= 'a' && buf[0] <= 'f') {
		port = buf[0] - 'a';
	} else {
		send_str(PSTR("Unknown port \""));
		usb_serial_putchar(buf[0]);
		send_str(PSTR("\", must be A - F\r\n"));
		return;
	}
	// second character is the pin number
	if (buf[1] >= '0' && buf[1] <= '7') {
		pin = buf[1] - '0';
	} else {
		send_str(PSTR("Unknown pin \""));
		usb_serial_putchar(buf[0]);
		send_str(PSTR("\", must be 0 to 7\r\n"));
		return;
	}
	// if the third character is a question mark, read the pin
	if (buf[2] == '?') {
		// make the pin an input
		*(uint8_t *)(0x21 + port * 3) &= ~(1 << pin);
		// read the pin
		val = *(uint8_t *)(0x20 + port * 3) & (1 << pin);
		usb_serial_putchar(val ? '1' : '0');
		send_str(PSTR("\r\n"));
		return;
	}
	// if the third character is an equals sign, write the pin
	if (num >= 4 && buf[2] == '=') {
		if (buf[3] == '0') {
			// make the pin an output
			*(uint8_t *)(0x21 + port * 3) |= (1 << pin);
			// drive it low
			*(uint8_t *)(0x22 + port * 3) &= ~(1 << pin);
			return;
		} else if (buf[3] == '1') {
			// make the pin an output
			*(uint8_t *)(0x21 + port * 3) |= (1 << pin);
			// drive it high
			*(uint8_t *)(0x22 + port * 3) |= (1 << pin);
			return;
		} else {
			send_str(PSTR("Unknown value \""));
			usb_serial_putchar(buf[3]);
			send_str(PSTR("\", must be 0 or 1\r\n"));
			return;
		}
	}
	// otherwise, error message
	send_str(PSTR("Unknown command \""));
	usb_serial_putchar(buf[0]);
	send_str(PSTR("\", must be ? or =\r\n"));
}


