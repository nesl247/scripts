function __github_https_to_ssh -a url
  set -l urlPart (echo $url | grep -Eo "([A-z0-9-]+\/[A-z0-9-]+.git)")
  set -l newUrl "git@github.com:$urlPart"
  git remote set-url origin $newUrl
end

function __github_ssh_to_https -a url
  set -l urlPart (echo $url | grep -Eo "([A-z0-9-]+\/[A-z0-9-]+.git)")
  set -l newUrl "https://github.com/$urlPart"
  git remote set-url origin $newUrl
end

function github_remote_switch
  set -l url (git remote -v | tail -1 | awk '{ print $2 }')
  if string match -qr "^https" $url
    __github_https_to_ssh $url
    echo "Switched your GitHub repo to use ssh remote."
  else
    __github_ssh_to_https $url
    echo "Switched your GitHub repo to use https remote."
  end
end
