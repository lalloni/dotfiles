function deurl -d "url decode its arguments"
    echo (string unescape --style=url $argv)
end
