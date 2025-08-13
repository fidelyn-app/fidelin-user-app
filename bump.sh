# na raiz do repo
export PR_TITLE="[MINOR]: Teste bump local"
export PR_BODY="Descrição do changelog gerada a partir deste PR."
export PR_NUMBER="123"
export PR_USER="seuUser"
# opcionalmente força o tipo:
# export BUMP_TYPE="minor"

python3 scripts/bump.py