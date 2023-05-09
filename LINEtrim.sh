read -p "is PNG?" answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
for f in *.png; do convert "$f" -depth 32 -trim "${f%%}"; done
else
for f in *.gif; do convert "$f" -coalesce -repage 0x0 "${f%%}"; convert "$f" -trim "${f%%}"; done
fi
