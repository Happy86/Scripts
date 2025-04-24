#!/usr/bin/env bash

# FILENAME:    ~/bin/brew-update.sh
# VERSION:     2025-04-23_14-40
# LICENSE:     WTFPL
# DESCRIPTION: Script that "properly" Updates libreoffice with brew/mac without
#              breaking the libreoffice-language-pack.
#              Yes. This is a bodge!
#              The proper/sane solution is to use a proper Linux distribution with
#              a proper package manager like Debian with dpkg/apt and not use shitty/
#              proprietary operating systems. ;-)

set -uo pipefail;

sudo -v;

# find out if docutil is installed
IS_INSTALLED_DOCKUTIL=$(brew list | grep -c 'dockutil');
if [[ "${IS_INSTALLED_DOCKUTIL}" -eq 0 ]]
then
  echo " brew install dockutil";
  brew install dockutil;
  echo "";
fi

# check if LibreOffice has been placed in the dock and at which position
echo " dockutil --find \"LibreOffice\" # Checking if LibreOffice is in the Dock.";
dockutil --find "LibreOffice";
FOUND_LIBREOFFICE_IN_DOCK=${?};
if [[ "${FOUND_LIBREOFFICE_IN_DOCK}" -eq 0 ]]
then
  POSITION_OF_LIBREOFFICE_IN_DOCK=$(dockutil --find "LibreOffice" | awk -F 'slot ' '{print $2}' | awk -F ' in' '{print $1}');
  echo "";
fi


IS_INSTALLED_LIBREOFFICE=$(brew list --casks | grep -c 'libreoffice');
IS_INSTALLED_LIBREOFFICE_LANGPACK=$(brew list --casks | grep -c 'libreoffice-language-pack');

if [[ "${IS_INSTALLED_LIBREOFFICE}" -ne 0 ]]
then
  LIBREOFFICE_OUTDATED_CHECK=$(brew outdated --cask | grep -c libreoffice);
  if [ "${LIBREOFFICE_OUTDATED_CHECK}" -ne 0 ];
  then

    if [[ "${IS_INSTALLED_LIBREOFFICE_LANGPACK}" -ne 0 ]]
    then
      # LibreOffice UND Sprachpaket sind installiert.
      echo "==> Prüfe ob es Updates für Libreoffice gibt ...";


      LIBREOFFICE_AVAILABLE_VERSION=$(brew outdated --casks --greedy --json | jq .casks | jq '.[] | select(.name=="libreoffice")' | jq .current_version | tr -d '"');
      LIBREOFFICE_LANGPACK_AVAILABLE_VERSION=$(brew outdated --casks --greedy --json | jq .casks | jq '.[] | select(.name=="libreoffice-language-pack")' | jq .current_version | tr -d '"');

      if [[ "${LIBREOFFICE_AVAILABLE_VERSION}" == "${LIBREOFFICE_LANGPACK_AVAILABLE_VERSION}" ]]
      then
        echo "==> Es gibt ein LibreOffice Update. :-)";

        # deinstallieren
        echo " brew uninstall --cask libreoffice";
        brew uninstall --cask libreoffice;

        echo " brew uninstall --cask libreoffice-language-pack";
        brew uninstall --cask libreoffice-language-pack;

        # installieren
        ## LibreOffice installieren
        echo " brew install --cask --no-quarantine libreoffice";
        brew install --cask --no-quarantine libreoffice;

        if [ -d /Applications/LibreOffice.app ];
        then
          ## Prüfen ob der Index vom Betriebssystem LibreOffice schon gesehen hat. Wenn nicht warten und wieder versuchen.
          ## So lange der Index vom Betriebssystem /Applications/LibreOffice.app noch nicht kennt kann das Sprachpaket NICHT installiert werden!
          echo " ... please wait";
          while [ $(mdfind "kMDItemContentType == 'com.apple.application-bundle' && kMDItemFSName == 'LibreOffice.app'" -onlyin '/Applications' | wc -l) -eq 0 ];
          do
            TEMP=$(ls /Applications/LibreOffice.app 2>&- || true);
            echo " -> Bitte warten bis Macintosh das /Applications/LibreOffice.app Verzeichnis indiziert hat! ...";
            echo "    Schlafe 1 Sekunde";
            echo "";
            sleep 1;
          done;

          ## Sprachpaket installieren
          echo " brew install --cask --no-quarantine libreoffice-language-pack";
          brew install --cask --no-quarantine libreoffice-language-pack;

        else
          echo "FEHLER: Leider liegt LibreOffice nicht im Dateisystem unter /Applications/LibreOffice.app";
          echo "        Dementsprechend kann auch KEIN Sprachpaket installiert werden!!!";
        fi

        echo " xattr -crv /Applications/LibreOffice.app";
        xattr -crv /Applications/LibreOffice.app;
        echo "";

        if [[ "${FOUND_LIBREOFFICE_IN_DOCK}" -eq 0 ]]
        then
          echo "";
          echo " dockutil --add /Applications/LibreOffice.app --position ${POSITION_OF_LIBREOFFICE_IN_DOCK} --restart";
          dockutil --add /Applications/LibreOffice.app --position "${POSITION_OF_LIBREOFFICE_IN_DOCK}" --restart;
          echo "";
        fi

      else
        echo "==> WARNUNG: Leider liegen libreoffice und libreoffice-language-pack noch NICHT in der selben Version vor.";
        echo "             Einfach nochmal einen Tag warten und dann kann LibreOffice inkl. Sprachpaket sicher aktualisiert werden. :-)";
        echo "             libreoffice -> ${LIBREOFFICE_AVAILABLE_VERSION} / libreoffice-language-pack -> ${LIBREOFFICE_LANGPACK_AVAILABLE_VERSION}";
      fi
    else
      # NUR LibreOffice ist installiert.
      echo "  brew upgrade --cask libreoffice";
      brew upgrade --cask libreoffice;

      echo " xattr -crv /Applications/LibreOffice.app";

      xattr -crv /Applications/LibreOffice.app;
      echo "";

      if [[ "${FOUND_LIBREOFFICE_IN_DOCK}" -eq 0 ]]
      then
        echo "";
        echo " dockutil --add /Applications/LibreOffice.app --position ${POSITION_OF_LIBREOFFICE_IN_DOCK} --restart";
        dockutil --add /Applications/LibreOffice.app --position "${POSITION_OF_LIBREOFFICE_IN_DOCK}" --restart;
        echo "";
      fi
    fi
  else
    echo "==> Es gibt kein Update für LibreOffice.";
    echo "";
  fi
fi
echo "";


echo "==> Update und installiere etwaige Updates für brew und durch brew installierte Kommandozeilensoftware:";
echo " brew update"
brew update
echo "";
echo " brew upgrade --formulae"
brew upgrade --formulae
echo "";
echo "";


echo "==> Aktualisiere brew casks (nur halt NICHT libreoffice):";
echo " brew outdated --casks --greedy | grep -v libreoffice | xargs brew upgrade --casks --greedy --force";
brew outdated --casks --greedy | grep -v libreoffice | xargs brew upgrade --casks --greedy --force
