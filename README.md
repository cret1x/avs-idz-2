# ИДЗ №1 Вариант 23
## Амирханов Никита Русланович БПИ219

### Условия
Разработать программу, которая ищет в ASCII-строке заданную
подстроку и возвращает индекс первого символа первого вхож-
дения подстроки в строке. Подстрока вводится как параметр.

### Задание решено на 10 баллов.
 - Есть исходный код на си, скомпилированный с разными опциями, шаги рефакторинга ассемблероного кода пропущены т.к. писалась программа на ассемблере с нуля.
 - Есть сравнительные тесты показывающие скорость работы обоих программ.
 - Есть генератор случайных чисел с указанием границ
 - Есть ввод-вывод из файла
 - Есть измерение времени работы программы
 - Есть текст программы на языке ассемблера без использования си функций
 - Весь ассемблерный код содержит поясняющие комментарии

### Структура папок
 - `/asm` содержит исходный код на ассембеле без использования си функций
 - `/asm/lib` содержит файлы с дополнительными функциями
 - - `array.s` - работа с массивами
 - - `io.s` - ввод/вывод из консоли/файлов
 - - `str.s` - работа со строками
 - - `time.s` - замер времени
 - - `rand.s` - генерация случайных чисел
 - `/asm/main.s` - главный файл программы
 - `/c-stuff` содержит исходный код на языке си и результаты его компиляции
 - `/tests` папка с тестами
 - Файл `make-tests.py` позволяет создавать тесты необходимой длины

### Запуск ассемблерного кода
```sh
make compile    ; компилирует все дополнительные библиотеки
make build      ; компилирует основой код с добавлением библиотек
```
Далее, чтобы выполнить просто `./main`. Для работы с консолью необходимо указать флаг `-c`. Для ввода и вывода в файл необходимо укзазать флаг `-f` и три аргумента `./main -f <input_file_string> <input_file_substring> <output_file>`. Для работы с генератором случайных чисел необходимо набрать `./main -r <string_len> <substring_len>`. В таком случае на экран будет выведена сгенерированная строка и подстрока. Ограничение на ввод строки через консоль и при генерации 4096 символов. Для ввода из файла это ограничение 134217728 символов. При вводе большего числа будет выведено сообщение или будут просто отсечены остальные символы которые не помещаются в эту длину. Ограничения на вводмимые символы нет, внутри строит проверка на диапазон 0-127.

### Запуск си кода
```sh
gcc main.c -o main
```
В си программе отсутствует ручной ввод вывод. В остальном используются те же аргументы и их ограничения.

### Важно
 - В папке `tests` нет тестов на 134217728 символов из за большого размера файла.
 - Ввод строки и подстроки разбит на два файла
 - Пример файла для ввода строки
```
some text
new line

```
 - Пример файла для ввода подстроки
```
new
```

### Работа с рандомайзером
В обоих случая надо при запуске указать параметры. Пример:
```sh
$ ./main -r 20 1
Generated string: <Th|$8L^r.BVh~(<
Generated substring: T
Position of substring: 1
```
Выведется сгеренированная строка длиной 20 и подстока длиной 1. Резултат выполнения будет выведен в консоль.

### Тестирование ASM
 - Тест где будет найдена подстрока `./main -f ../tests/t1str.txt ../tests/t1sub.txt out.txt`
 ```
 hello from
 the other side!
 ```
 ```
 the
 ```
 Результат
 ```
 11
 ```
 - Тест где не будет найдена подстрока `./main -f ../tests/t2str.txt ../tests/t2sub.txt out.txt`
 ```
 aaaaaa
 ```
 ```
 bbb
 ```
 Результат
 ```
 -1
 ```
 - Тест где будет показано что выводится первое вхождение `./main -f ../tests/t3str.txt ../tests/t3sub.txt out.txt`
 ```
 hello from the hell!
 ```
 ```
 hell
 ```
 Результат
 ```
 0
 ```
 - Тест где будут неверные символы на входе `./main -f ../tests/t4str.txt ../tests/t4sub.txt out.txt`
 ```
 Немного текста,
 где есть символы выше 127!!
 текст
 ```
 ```
 Строка а
 ```
 Результат
 ```
 Invalid chars in string. Must be in range [0-127].
 ```

### Тестирование C
 - Тест где будет найдена подстрока `./main -f ../tests/t1str.txt ../tests/t1sub.txt out.txt`
 ```
 hello from
 the other side!
 ```
 ```
 the
 ```
 Результат
 ```
 11
 ```
 - Тест где не будет найдена подстрока `./main -f ../tests/t2str.txt ../tests/t2sub.txt out.txt`
 ```
 aaaaaa
 ```
 ```
 bbb
 ```
 Результат
 ```
 -1

 ```
 - Тест где будет показано что выводится первое вхождение `./main -f ../tests/t3str.txt ../tests/t3sub.txt out.txt`
 ```
 hello from the hell!
 ```
 ```
 hell
 ```
 Результат
 ```
 0
 ```
 - Тест где будут неверные символы на входе `./main -f ../tests/t4str.txt ../tests/t4sub.txt out.txt`
 ```
 Немного текста,
 где есть символы выше 127!!
 текст
 ```
 ```
 Строка а
 ```
 Результат
 ```
 Invalid chars in string. Must be in range [0-127].
 ```

### Вывод тестирования
Результаты работы программ совпадают

### Сравнение прогамм на си и asm
1. Размер исполняемого файла
 - Размер ассемблероного файла сгенерированного из си кода при помощи флагов `-masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions -Os` составляет всего 332 строки. А с оптимизацией `-Ofast` 377 строк. В то же время размер самописной программы на ассемблере составляет 354 строк в main файле + 560 строк в вспомогательных файлах. Однако размер исполняемого файла на ассемблере составляет 8,7K а у программы на си 13K, а с флагом `-Os` тоже 13K.
2. Время работы программ 
 - Тестировалась работа программ написанных на ассемблере, на си, на ассемблероном коде, скомпилированным при помощи флага `-Ofast`, а так же при помощи флага `-Os`.
 - На тесте в 100000 элементов:
 ```
asm                         c:          -Ofast asm  -Os asm  
--------------------------------------------------------------
Read:          0.45912139   | 0.000501  | 0.000405  | 0.000406
Calculations:  0.295840     | 0.000024  | 0.000029  | 0.000024
Write:         0.100964     | 0.000004  | 0.000004  | 0.000007
 ```
  - На тесте в 1000000 элементов:
 ```
asm:                        c:          -Ofast asm  -Os asm
 -------------------------------------------------------------
Read:          0.442891754  | 0.005343  | 0.004286  | 0.004543
Calculations:  0.2798335    | 0.000260  | 0.000331  | 0.000343
Write:         0.102700     | 0.000007  | 0.000006  | 0.000007
 ```
  - На тесте в 10000000 элементов:
 ```
asm:                        c:          -Ofast asm  -Os asm
--------------------------------------------------------------
Read:          4.531438339  | 0.051311  | 0.041249  | 0.042010
Calculations:  0.28674125   | 0.003088  | 0.002837  | 0.003001
Write:         0.128779     | 0.000012  | 0.000012  | 0.000012
 ```
  - На тесте в 100000000 элементов:
 ```
asm:                        c:          -Ofast asm  -Os asm
 -------------------------------------------------------------
Read:          44.865623908 | 0.506200  | 0.401700  | 0.364778
Calculations:  0.277846580  | 0.028522  | 0.026400  | 0.026756
Write:         0.107652     | 0.000014  | 0.000014  | 0.000015
 ```
 3. Обработка некорректных данных
  - Количество элементов больше 100000000
  - - Обе программы отсекают символы за пределом.
  - Указанного файла не существует
  - - Программы нвыводят сообщение об ошибке.
  - Есть символы не попадающие в диапазон
  - - Обе программы выводят сообщение об ошибке



### Вывод
Компилятор gcc опять оказался умнее меня. Скорость работы программы на чистом ассемблере оказалась меньше чем на си с разницей до 11 раз. При этом время на операции ввода и вывода оказалось в среднем в 80 раз больше. Размер исполняемого файла на ассемблере оказлся меньше чем на си. При этом, написание когда на ассемблее во много раз дольше.