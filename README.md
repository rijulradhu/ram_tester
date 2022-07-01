# Ram Tester
Done as a part of CS F241Microprocessor Programming & Interfacing at BITS Pilani, Goa Campus in Fall semester 2019

We designed a microprocessor-based RAM tester. The tester is able to test 6116 and 6164 RAM chips. The tester tests each bit of the RAM individually. For a byte of RAM, the first bit(D0) is written as zero (0) and read back, then a one (1) is written into the bit and again it is read back. If the two read operations result in a bit D0 to contain a zero and one respectively then the bit is inferred as good. Any other result indicates a faulty bit. The test is repeated for all bits of a byte and for all bytes of the RAM. The summary result PASSED/FAILED is displayed on the board - on a 4 7-segment display unit.
