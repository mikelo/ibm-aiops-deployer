#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# LOAD LOGS DIRECTLY INTO ELASTICSEARCH
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ADAPT VALUES
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


export APP_NAME=robot-shop
export INDEX_TYPE=logs
export TRAINING_DATA_URL=https://github.com/niklaushirt/ibmaiops-trainingdata.git



if [[  $AIOPS_NAMESPACE =~ "" ]]; then
    # Get Namespace from Cluster 
    echo "   ------------------------------------------------------------------------------------------------------------------------------"
    echo "   🔬 Getting Installation Namespace"
    echo "   ------------------------------------------------------------------------------------------------------------------------------"
    export AIOPS_NAMESPACE=$(oc get po -A|grep aiops-orchestrator-controller |awk '{print$1}')
    echo "       ✅ OK - IBMAIOps:    $AIOPS_NAMESPACE"
fi

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT EDIT BELOW
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo "   ------------------------------------------------------------------------------------------------------------------------------"
echo "   🌏 Getting Training Data from $TRAINING_DATA_URL"
echo "   ------------------------------------------------------------------------------------------------------------------------------"
rm -r -f ./tools/02_training/TRAINING_FILES
git clone $TRAINING_DATA_URL ./tools/02_training/TRAINING_FILES/ELASTIC/


unzip ./tools/02_training/TRAINING_FILES/ELASTIC/robot-shop/logs/data-log-training-elk.zip -d ./tools/02_training/TRAINING_FILES/ELASTIC/robot-shop/logs


echo ""
./tools/02_training/scripts/load-es-index.sh

rm -r -f ./tools/02_training/TRAINING_FILES

