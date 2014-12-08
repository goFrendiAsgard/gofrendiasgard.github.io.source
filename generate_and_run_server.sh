cp ./output/.git ./._output_git_backup -R
pelican content -s publishconf.py
cd output
python -m SimpleHTTPServer
cd ..
mv ./._output_git_backup ./output/.git -f