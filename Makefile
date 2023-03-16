all:
	mkdir -p notes
	ocamlc -I +str str.cma main.ml