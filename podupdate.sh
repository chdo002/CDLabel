
# 第一个参数记为commit 默认update
param=$1



if [[ $param = '' ]]
then
	read -p '输入本次commit注释（默认为update）:' commm
	param=$commm;
	if [[ $param = '' ]]; then
		param='update'
	fi
fi


# 第二个参数记为tag版本，默认0.0.1
param2=$2
if [[ $param2 = '' ]]
then
	read -p '输入本次pod更新版本（默认为0.1.0）:' commm
	param2=$commm;
	if [[ $param2 = '' ]]; then
		param2='0.1.0'
	fi
fi


echo '<<<<提交>>>>'
git status
echo '--添加'
git add -A
echo '--commit'

git commit -m "$param"

if [ "$?" != "0" ]; then
   echo "commit 的时候出问题了😑" 
   exit 1
fi 

echo '--提交'
git push origin 

if [ "$?" != "0" ]; then
   echo "push 的时候出问题了😑" 
   exit 1
fi 


echo '<<<<删除tag>>>>'
# 这里的版本可以由外部传入
git tag --d $param2
git push origin --delete tag $param2

echo '<<<<添加tag>>>>'
git tag -m "$param2" "$param2"
git push origin --tags

echo '<<<<清除pod缓存>>>>'
pod cache clean --all


git log --all --pretty  --graph --date=short
# git status

echo "完成! \n提交版本: $param. \npod tag: $param2";

