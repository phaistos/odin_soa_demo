soa_demo: main.odin
	odin build . -o:speed -microarch:native -out:soa_demo
	
soa_demo_asm: main.odin
	odin build . -o:speed -microarch:native -build-mode=asm -out:soa_demo.S
