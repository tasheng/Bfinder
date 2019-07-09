#!/bin/bash

[[ $0 != *.sh ]] && {
    echo -e "\e[31;1merror:\e[0m use \e[32;1m./script.sh\e[0m instead of \e[32;1msource script.sh\e[0m" ; return 1; }

#
REAL=0
SKIM=0
MAXFILENO=1000000
#
#################################################################################################################################################################################################################
##                                                                                      X3872ToJpsiRho_prompt                                                                                                  ##
## ls -d /mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat*_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat*_1033p1_pt6tkpt0p7dls0_v3/*/0000 ##
#################################################################################################################################################################################################################
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat5_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat5_1033p1_pt6tkpt0p7dls0_v3/190529_035808/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat5_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat10_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat10_1033p1_pt6tkpt0p7dls0_v3/190529_035851/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat10_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat15_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat15_1033p1_pt6tkpt0p7dls0_v3/190529_040529/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat15_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat30_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat30_1033p1_pt6tkpt0p7dls0_v3/190529_040949/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat30_1033p1_pt6tkpt0p7dls0_v3" ;
INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat50_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat50_1033p1_pt6tkpt0p7dls0_v3/190529_041105/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat50_1033p1_pt6tkpt0p7dls0_v3" ;
#################################################################################################################################################################################################################

##############################################################
# Do not modify lines below if you do not know what it means #
##############################################################

##
movetosubmit=${1:-0}
runjobs=${2:-0}

[[ $movetosubmit -eq 0 && $runjobs -eq 0 ]] && {
    echo "Usage: ./submit_condor_checkfile.sh [move script] [submit jobs]" ;
    echo "Test compiling macros..." ; 
    cd .. ;
    g++ loop.C $(root-config --libs --cflags) -Werror -Wall -O2 -g -o loop.exe && rm loop.exe ;
    cd condor ;
}

#
OUTPUTPRIDIR="/mnt/hadoop/cms/store/user/jwang/BntupleRun2018condor/"
WORKDIR="/work/$USER/Bntuple/"
OUTPUTDIR="${OUTPUTPRIDIR}/${OUTPUTSUBDIR}"
LOGDIR="logs/log_${OUTPUTSUBDIR}"

##
mkdir -p $WORKDIR

#
if [[ $movetosubmit -eq 1 ]]
then
    if [[ $(hostname) == "submit-hi2.mit.edu" || $(hostname) == "submit.mit.edu" ]]
    then
        cd ..
        g++ loop.C $(root-config --libs --cflags) -Werror -Wall -O2 -g -o loop.exe
        cd condor

        mv ../loop.exe $WORKDIR/
        cp $0 $WORKDIR/
        cp loop-Bntuple.sh $WORKDIR/
        cp loop-condor-checkfile.sh $WORKDIR/
    else
        echo -e "\e[31;1merror:\e[0m compile macros on \e[32;1msubmit-hiX.mit.edu\e[0m or \e[32;1msubmit.mit.edu\e[0m."
    fi
fi

#
if [[ $runjobs -eq 1 ]]
then
    if [[ $(hostname) == "submit.mit.edu" ]]
    then
        ./loop-condor-checkfile.sh $INPUTDIR $OUTPUTDIR $REAL $SKIM $MAXFILENO $LOGDIR
    else
        echo -e "\e[31;1merror:\e[0m submit jobs on \e[32;1msubmit.mit.edu\e[0m."
    fi
fi


#################################################################################################################################################################################################################
##                                                                                      X3872ToJpsiRho_prompt                                                                                                  ##
## ls -d /mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat*_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat*_1033p1_pt6tkpt0p7dls0_v3/*/0000 ##
#################################################################################################################################################################################################################
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat5_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat5_1033p1_pt6tkpt0p7dls0_v3/190529_035808/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat5_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat10_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat10_1033p1_pt6tkpt0p7dls0_v3/190529_035851/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat10_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat15_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat15_1033p1_pt6tkpt0p7dls0_v3/190529_040529/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat15_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat30_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat30_1033p1_pt6tkpt0p7dls0_v3/190529_040949/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat30_1033p1_pt6tkpt0p7dls0_v3" ;
# INPUTDIR="/mnt/hadoop/cms/store/user/wangj/Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat50_TuneCP5_5020GeV_Drum5F/crab_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat50_1033p1_pt6tkpt0p7dls0_v3/190529_041105/0000/" ; OUTPUTSUBDIR="ntuple_20190609_Bfinder_20190520_Hydjet_Pythia8_X3872ToJpsiRho_prompt_Pthat50_1033p1_pt6tkpt0p7dls0_v3" ;
#################################################################################################################################################################################################################
