text='Дзенаускас Игорь Дмитриевич, 08.11.2002, Гимназия №5, Информационные системы и технологии'

upChars='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ'
downChars='абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz'

ruUpPart='АБВГДЕЗИЙКЛМНОПРСТУФЪЫЬЭ'
engUpPart="ABVGDEZIYKLMNOPRSTUF'Y'E"

fileName='ИСТ-112_Дзенаускас_ИД_ЛР4_Б'
declare -A translit=(["Ё"]="YO" ["Ж"]="ZH" ["Х"]="KH" ["Ц"]="TS" ["Ч"]="CH" ["Ш"]="SH" ["Щ"]="SHCH" ["Ю"]="YU" ["Я"]="YA")

yes $text | head -n 500000 |sed "y/$downChars/$upChars/" | iconv -f UTF8 -t CP1251 | iconv -f CP1251 -t CP866 | iconv -f CP866 -t CP1251 > $fileName.txt

cat $fileName.txt | iconv -f CP1251 -t UTF8 | sed "y/$ruUpPart/$engUpPart/" > $fileName.tmp
sed -i ''"$(for symbol in "${!translit[@]}"; do echo "s/$symbol/${translit[$symbol]}/g;"; done)"'' "$fileName.tmp"

cat $fileName.tmp | iconv -f UTF8 -t CP1251 > $fileName.txt
rm $fileName.tmp

zip $fileName.zip $fileName.txt

rm $fileName.txt
