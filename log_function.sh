#!/usr/bin/env bash

log() {
    local status="$1"
    local msg="$2"

    case "$status" in
        -i) echo -e "\033[1;34m[INFO]\033[0m $msg"        ;;
        -s) echo -e "\033[1;32m[SUCCESS]\033[0m $msg"     ;;
        -w) echo -e "\033[1;33m[WARN]\033[0m $msg"        ;;
        -e) echo -e "\033[1;31m[ERROR]\033[0m $msg" >&2   ;;
        -p) echo "Opção inválida, valide o -h " && exit 1 ;;
        -a) echo "--------------------------------------------------" ;;
    esac
}
