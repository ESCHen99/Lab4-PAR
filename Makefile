# C compiler
OMPC    = icc # gcc
OPT2 	= -O2
OPTG0 	= -O0
CFLAGS  = -g -std=c99 -Wall
OPENMP	= -fopenmp
LFLAGS  = -lm
CINCL    = -I.
CLIBS    = -L.

# Tareador compiler
TAREADORCC = tar-clang
TAREADOR_FLAGS = -tareador-lite 
#TAREADOR_FLAGS = -tareador-lite -isystem/scratch/nas/1/par0/Soft

TARGETS	= multisort multisort-tareador multisort-omp multisort-omp-tree multisort-omp-tree-final multisort-omp-tree-depend multisort-omp-leaf
all: $(TARGETS)

kernels.o: kernels.c 
	$(OMPC) -c $(CFLAGS) $(OPT2) $^ -o $@ 

multisort: multisort.c kernels.o
	$(OMPC) $(CFLAGS) $(OPT2) $+ $(LFLAGS) -o $@ 

multisort-tareador: multisort-tareador.c kernels-tareador.c
	$(TAREADORCC) $(TAREADOR_FLAGS) $(CFLAGS) $(OPTG0) $+ $(CINCL) $(LFLAGS) -o $@ $(CLIBS)

multisort-omp: multisort-omp.c  kernels.o
	$(OMPC) $(CFLAGS) $(OPT2) $(OPENMP) $+ $(LFLAGS) -o $@ 


multisort-omp-leaf: multisort-omp-leaf.c  kernels.o
	$(OMPC) $(CFLAGS) $(OPT2) $(OPENMP) $+ $(LFLAGS) -o $@ 

multisort-omp-tree: multisort-omp-tree.c  kernels.o
	$(OMPC) $(CFLAGS) $(OPT2) $(OPENMP) $+ $(LFLAGS) -o $@ 

multisort-omp-tree-final: multisort-omp-tree-final.c  kernels.o
	$(OMPC) $(CFLAGS) $(OPT2) $(OPENMP) $+ $(LFLAGS) -o $@ -Wall -Wpedantic -fsanitize=undefined

multisort-omp-tree-depend: multisort-omp-tree-depend.c  kernels.o
	$(OMPC) $(CFLAGS) $(OPT2) $(OPENMP) $+ $(LFLAGS) -o $@ 


clean:
	rm -fr $(TARGETS) *.o .tareador_precomputed* *.log

ultraclean:
	rm -fr $(TARGETS) *.o .tareador_precomputed* *.prv *.pcf *.row dependency_graph* *.times.txt *.sh.e* *.sh.o* *.ps *.txt *.log TRACE.* set-0 logs

