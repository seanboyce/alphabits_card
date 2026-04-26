# AlphaBits Card

This is an electronic business card I made for a colleague.

It is a 3-color design: green, white, and silver. The green layer is the plan PCB, the white layer is silkscreen, and the silver layer is solder mask + copper + solder paste.

Integrated into the front design are 3 LEDs that flash in sequence, then pause, then repeat.

# That's it?

Well, yes and no. You may notice that there are no resistors on the 0402 LEDs, the attiny10 can definitely deliver enough current to burn them out.

So we flash them for only some microseconds, the average current is still quite acceptable, and this means no power is wasted being dissipated in a resistor. This also makes them look brighter to human eyes. We also use the watchdog timer instead of a "normal" timer, so we can keep the system clock off most of the time (to save more power).

During standby, the power consumption is approximately 5uA. The LED flashing time is short enough that it doesn't add significantly to that. Altogether, this has 3 consequecnces:

1. The CR2032 cell should last some 3-4 years. We save 10 cents on an off switch, which would look ugly anyway.
2. The LED flash sequence is clearly human-visible. However, it offers poor visibility to machines, specifically things like smartphone cameras. The flash time is very short and the shutter speed of consumer cameras does not capture it reliably.
3. We save 0.3 cents on 0402 resistors (yes, I know, I am very tight with money).

# Why?

In Asia, we still use business cards. However, in recent years I noticed we don't really "exchange" them except in very formal contexts. Instead, we just take a photo of the card and the person, then send it to ourselves on chat or email.

So, since we're not giving them out any more, why not do something a little more fun? Specifically:

1. Add the QR code so that people who already have their phone out can just visit your website right away.
2. PCB business cards look cool, if I'm not handing them out, spending (a little) is OK!
3. The fact that the sequence of lights is not-machine visible (e.g. to smartphones, which again, we already have out as part of the interaction) is a memorable talking point, and the fact that it's only visible in-person is a nice reference to the importance that we met in-person.
4. I don't want to deal with it running out of batteries, so the battery has to last years.
