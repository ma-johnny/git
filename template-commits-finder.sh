git_dir=
git_branch=
output_file=
keywords=""

commands=`echo "$keywords" | sed 's/|/\\\\|/g' | awk -v git_branch=$git_branch '
	BEGIN { FS="[&]" } {
		for (i = 1; i <= NF; i += 1) 
			printf "git log %s --grep \"%s\" --format=%H | awk '\''NR==1{print \"%s\"} {print \"\\\\t\"$0}'\''\n", 
			git_branch, $i, $i
	}
'`

cd $git_dir
echo "$commands"
eval "$commands" 2>/dev/null >> $output_file