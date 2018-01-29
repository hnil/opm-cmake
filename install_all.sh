for repo in opm-common opm-parser opm-output opm-material opm-grid opm-core ewoms opm-simulators opm-upscaling
do
  git clone https://github.com/OPM/$repo
done

git clone https://github.com/Statoil/libecl
#for repo in dune-common dune-geometry dune-grid dune-istl dune-localfuntions do
#  git clone --branch v2.5.1 https://gitlab.dune-project.org/core/$repo.git
#done
#dunecontrol all
	    
