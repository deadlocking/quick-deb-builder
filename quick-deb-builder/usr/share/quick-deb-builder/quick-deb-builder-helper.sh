#! /bin/bash

# RETURN CODES personalizados do AVD Launcher:
# 	50 = "Yes" para fechar
#	100 = "No" para fechar

APP_NAME="Quick DEB Builder"
VERSION="0.1.0"
HELP_DESCRIPTION_TEXT="$APP_NAME is a simple tool that quickly creates .deb packages from an existing build tree."
APP_AUTHOR="Copyright (C) 2015 Gustavo Moraes http://about.me/gustavosotnas"

displayAboutDialog()
{
	yad --title "About $APP_NAME" --info --center --width=500 --image="package" --window-icon="package" --icon-name="package" --text "<b>$APP_NAME</b>\n\n$VERSION\n\n$HELP_DESCRIPTION_TEXT <b>$ADVICE_DESCRIPTION_TEXT</b>\n\n$APP_AUTHOR" --text-align=center --borders=5 --button=Close:0;
}

displayCancelDialog()
{
	yad --title "$APP_NAME" --info --center --width=350 --image="help" --window-icon="package" --icon-name="package" --text "<b>Are you sure you want to exit from $APP_NAME?</b>" --text-align=center --button=No:1 --button=Yes:0;
}

verify_term_all()
{
	if [ "$?" == "0" ] # Se o usuário quer terminar tudo (apertou o botão "Yes")
	then
		killall yad; # Mata o yad para o processo pai continuar executando (gera o RETURN CODE 143)
		exit 50; #killall yad avd-launcher.sh; exit; # Mata os pais e sai
	else
		exit 100; #exit; # Apenas sai do helper
	fi
}

verify_safe_exit()
{
	if [ "$?" == "0" ] # Se o usuário quer terminar tudo (apertou o botão "Yes")
	then
		exit 50; #killall yad avd-launcher.sh; exit; # Mata os pais e sai
	else
		exit 100; #exit; # Apenas sai do helper
	fi
}

case $1 in
	"about") displayAboutDialog;; # Abre uma janela de diálogo "sobre"
	"cancel") displayCancelDialog; verify_term_all;; # Interrompe todos os processos relacionados ao AVD Launcher
	"safe-exit") displayCancelDialog; verify_safe_exit;;
esac;