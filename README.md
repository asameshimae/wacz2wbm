# wacz2wbm
Extract a list of URLs from a .wacz file, e.g. for submitting to the Wayback Machine

# Installation
1. Copy `wacz2wbm.sh` to the folder where you keep your .wacz files, or to the folder where you run browsertrix-crawler (e.g. a folder containing /crawls/) and ensure it is executable (`chmod +x wacz2wbm.sh`).
2. Run `./wacz2wbm.sh collection-name` where `collection-name` is the name (not path) of a .wacz file (you don't need to include the extension)

wacz2wbm will look for a wacz file in the current directory called `collection-name.wacz`, and will also look for `/crawls/collections/collection-name/collection-name.wacz`. If it finds either of these, it will output a list of URLs to a file called `collection-name.txt` in the current directory. If `xclip` is installed (e.g. `sudo apt install xclip`) it will also attempt to copy the URLs to the clipboard.

You may then for example go to `sheets.new` in your browser, paste the list, and submit to wayback-gsheets.
