mkdir half/
read -p "is PNG?" answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
for f in *.png; do convert -resize 50% "$f" half/"$f"; done
else
mkdir coal/
for f in *.gif; do convert "$f" -coalesce coal/"${f%%}_temp.gif"; convert coal/"${f%%}_temp.gif" -resize 50% half/"$f"; rm -r coal; done
fi