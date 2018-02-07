function remove() {

if [[ -d $i ]]

then

  echo error:  file is a directory

elif [[ -e $i ]]

then

node=$(stat -c %i $i)

mv $i $i'_'$node

mv $i'_'$node ~/deleted

  if [[ ! -e ~/.restore.info ]]

   then

    touch ~/.restore.info

    echo $i'_'$node:$(readlink -f $i) >> ~/.restore.info

    echo $i has been safely removed, inode:$node

   else

    echo $i'_'$node:$(readlink -f $i) >> ~/.restore.info

    echo $i has been safely removed, inode:$node

   fi

else

   echo error: file does not exist

fi

}

 

function verifyDelete() {

for i in $*

do

if [[ -e ~/deleted ]]

then

  remove $*

else

mkdir ~/deleted

remove $*

fi

done

}

 

function option_i() {

if $varI

then

  read -p "are you sure you would like remove this file? " response

  if [[ $response = 'y' || $response = 'Y' || $response = 'yes' ]]

  then

   verifyDelete $*

  else

   echo terminate program

  fi

else

  verifyDelete $*

fi

}

 

if $varV

then

  option_i $*

  echo confirmation: removed $*

else

  option_i $*

fi