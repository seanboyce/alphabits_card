.CSEG ; First, we set up our interrupt vectors
.ORG 0 ;These have to be in the first few bytes of program memory
rjmp RESET ; Reset Handler -- useful to define in case of unexpected reset condition
rjmp RESET ; IRQ0 Handler(not used so point it to RESET)
rjmp RESET ; PCINT0 Handler(not used so point it to RESET)
rjmp RESET ; Timer0 Capture Handler(not used so point it to RESET)
rjmp RESET ; Timer0 Overflow Handler(not used so point it to RESET)
rjmp RESET ; Timer0 Compare A Handler(not used so point it to RESET)
rjmp RESET ; Timer0 Compare B Handler(not used so point it to RESET)
rjmp RESET ; Analog Comparator Handler(not used so point it to RESET)
rjmp WDT ; Watchdog Interrupt Handler -- used to flash the light!

RESET:

LDI r16, (1<<PRADC) | (1<<PRTIM0); disable peripherals to save power
OUT PRR, r16

;define some constants for convenience
LDI r18, 0x01 ; start with PB0 lit
LDI r17, 0x00
OUT PUEB, r17 ; make sure pullups are off, they waste power

;setup output and make sure it's low and the port is set for output
LDI r16, 0b00000111
OUT DDRB, r16
OUT PORTB, r17

;setup watchdog timer. Watchdog interrupt enable, watchdog reset disable.

;flash every 250 milliseconds (32768 CPU cycles)
LDI r16, (0<WDP0) | (0<<WDP1) | (1<<WDP2) | (0<<WDP3) | (0<<WDE) | (1<<WDIE) 

OUT WDTCSR, r16

;enable interrupts now that everything is set up
SEI 

;sleep mode power down -- the watchdog timer will still be running
LDI r16, (1<<SE) | (0<<SM0) | (1<<SM1) | (0<<SM2)
OUT SMCR, r16

;Set up a loop that just turns off the light and powers down the MCU
loop:
SLEEP
OUT PORTB, r17 ;first instruction that will run when returning from interrupt turns off the light
RJMP loop

;Will wake from sleep and perform the below (WDT is the interrupt vector for the watchdog timer). The number of NOP cycles (no-operation) sets the brightness. We could use a timer but it's not like we're running low on program flash and it doesn't really save any measurable amount of power to use a proper timer.

;9x NOP normal brightness, 15x NOP extra bright
WDT:
OUT PORTB, r18
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
ROL r18
SBRC r18,5 ; we only have 3 LEDs so this lights the three in sequence, then pauses for 0.5 seconds -- PB4 and PB5 are not available pins so writing to them does nothing.
LDI r18, 0x01
RETI ; return to loop
