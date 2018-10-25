for repo in opm-common opm-material opm-grid ewoms opm-simulators 
do
    cd "${repo}"
    git remote set-url origin git@github.com:hnil/"${repo}.git"
    #git remote set-url 
    #git remote add upstream https://github.com/OPM/"${repo}.git"
    #git remote set-url upstream https://github.com/OPM/"${repo}.git"
    #git remote set-url origin https://github.com/hnil/"${repo}.git"
    cd ..
done
#origin	git@github.com:hnil/opm-common.git (fetch)
#origin	git@github.com:hnil/opm-common.git (push)
#upstream	https://github.com/OPM/opm-common.git (fetch)
#upstream	https://github.com/OPM/opm-common.git (push)
