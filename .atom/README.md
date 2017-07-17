Packages backup :

    apm list --installed --bare | awk -F@ '{print $1}' > ~/.atom/packages.list

Packages install :

    apm install `cat ~/.atom/packages.list`

[https://discuss.atom.io/t/how-to-backup-all-your-settings/15674]
