#!/bin/sh

# 輸入版本
inputVersion="php@$1"

# 檢查輸入版本
inputVersionFound=$(brew list --versions | awk -v php_version="$inputVersion" '$0 ~ php_version {print}')
if [ -z "$inputVersionFound" ]; then
    echo ${inputVersion} "is not installed"
    echo "installed version list as follows ..."
    brew list --versions | awk '/php@/'

    exit 1
fi

# 找出現有版本
oldVersion="php@"$(php -v | head -n 1 | cut -d ' ' -f 2 | cut -c 1-3)

if [ "$inputVersion" == "$oldVersion" ]; then
    echo "You are already on ${inputVersion}" 

    exit 1
fi
    
echo "Switching from ${oldVersion} to ${inputVersion}"
echo "Switching your shell"

# 換到新版本
brew unlink "${oldVersion}"
brew link --force "${inputVersion}"
echo "All done!"

exit 1
