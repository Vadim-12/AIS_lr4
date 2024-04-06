text='Агарков Вадим Александрович | 24.04.2003 | Технологический лицей города Сыктывкара | Информационные системы и технологии'
filename='ИСТ-112АгарковВ.А.ЛР4а_текст'

uppercased_chars=$(echo 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ'| iconv -t CP1251)
lowercased_chars=$(echo 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz'| iconv -t CP1251)

ru_uppercased_chars=$(echo 'АБВГДЕЗИЙКЛМНОПРСТУФЪЫЬЭ' | iconv -t CP1251)
eng_uppercased_chars=$(echo "ABVGDEZIYKLMNOPRSTUFYE" | iconv -t CP1251)

declare -A difficult_translit=(["Ё"]="YO" ["Ж"]="ZH" ["Х"]="KH" ["Ц"]="TS" ["Ч"]="CH" ["Ш"]="SH" ["Щ"]="SHCH" ["Ю"]="YU" ["Я"]="YA")

condition="$(for symbol in "${!translit[@]}"; do echo "awk '{gsub(\"$(echo $symbol | iconv -t CP1251)\",\"$(echo ${translit[$symbol]} | iconv -t CP1251)\");print}' |"; done)"

yes $text|head -n 500000|iconv -f UTF8 -t CP1251|tr $downChars $upChars|iconv -f CP1251 -t CP866|iconv -f CP866 -t CP1251|tr "$ruUpPart" "$engUpPart"|eval ${condition:0:-1}>$fileName.txt

zip $fileName.zip $fileName.txt

rm $fileName.txt
