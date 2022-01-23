// class String
// author Doc | 16.05.2012 | WWW.XGM.RU
// author meiso | 23.01.2022 

define private SIZE_STRING_ARRAY = 10
type StringArray extends string array[SIZE_STRING_ARRAY]

struct String
{
    private string Main
    private string cache
    
    private int length
    
    // Конструктор
    static String create(string Main)
    {
        String data = String.allocate()
        data.Main = Main
        data.cache = Main
        data.length = StringLength(Main)
        return data
    }
    
    // Создает новый объект из строки
    String clone()
    {
        return String.create(Main)
    }
    
    // Преобразует объект в строкой тип
    void valueOf(string s)
    {
        this.Main = s
        this.length = StringLength(Main)
    }
    
    // Получает длину строки
    int getLength()
    {
        return this.length
    }

    // Получает содержимое строки
    string get()
    {
        return this.Main
    }
    
    bool equalsStr(string s)
    {
        return (s == Main)
    }
    
    bool equals(String s)
    {
        return (s.get() == Main)
    }
    
    // Обновить изменения строки
    void updateCache()
    {
        this.cache = this.Main
    }


    StringArray split(string splitChar)
    {
        int i = -1
        int startInd = 0
        String temp = this.clone()
        temp.removeAll(" ")
        int countSplit = countOf(splitChar)
        StringArray words = StringArray.create()
        whilenot(i++ == countSplit)
        {
            int charInd = temp.indexOf(splitChar)
            words[i] = SubString(temp.get(), startInd, startInd + charInd)
            temp.getSubStr(startInd + charInd + 1, temp.getLength())
        }
        return words
    }
    
    // Удаляет указанные символы из строки
    void removeAll(string s)
    {
        int i = 0
        int e = this.length
        int ls = StringLength(s)
        whilenot(i == e)
        {
            if (SubString(this.Main, i, i + ls) == s)
            {
                this.Main = SubString(this.Main, 0, i) + SubString(this.Main, i + ls, e)
                e = StringLength(this.Main)
                i--
            }
            i++
        }
        this.length = StringLength(Main)
    }
    
    int firstAfter(int b, string s)
    {
        int i = b, j = 0
        int e = this.length
        int ls = StringLength(s)
        whilenot(i == e)
        {
            if (SubString(this.Main, i, i + ls) == s) { return i }
            i++
        }
        return -1
    }
    
    // Подсчитывает количество подстрок
    int countOf(string s)
    {
        int i = 0, j = 0
        int e = this.length
        int ls = StringLength(s)
        whilenot(i == e)
        {
            if (SubString(this.Main, i, i + ls) == s) { j++ }
            i++
        }
        return j
    }
    
    // Индекс первого вхождения подстроки
    int indexOf(string s)
    {
        int i = 0
        int e = this.length
        int ls = StringLength(s)
        int index = -1
        whilenot(i == e)
        {
            if (SubString(this.Main, i, i + ls) == s) 
            { 
                return i 
            }
            i++
        }
        return index
    }
    
    // Индекс последнего вхождения подстроки
    int lastIndexOf(string s)
    {
        int i = 0
        int e = this.length
        int ls = StringLength(s)
        int index = -1
        whilenot(i == e)
        {
            if (SubString(this.Main, i, i + ls) == s)
            {
                return i + ls
            }
            i++
        }
        return index
    }

    /*
    int getInt(int num)
    {
        int i, j = 0, k
        int c = this.length
        int ints = 0
        whilenot (c < 0)
        {
            i = 0
            whilenot (i > c)
            {
                k = S2I(SubString(this.Main, i - 1, c))
                if (k != 0)
                {
                    ints[j] = k
                    j++
                }
                i++
            }
            c--
        }
        if (num > j) { num = j }
        return ints[num]
    }
    */

    // Вернуть подстроку
    void getSubStr(int index, int length)
    {
        this.Main = SubString(this.Main, index, index + length)
        this.length = StringLength(Main)
    }
    
    // Входит ли подстрока в строку
    bool contains(string s)
    {
        int i = 0
        int e = this.length
        int ls = StringLength(s)
        whilenot(i == e)
        {
            if (SubString(this.Main, i, i + ls) == s) { return true }
            i++
        }
        return false
    }
    
    // Сбрасывает изменения строки
    void reset()
    {
        this.valueOf(this.cache)
    }
    
    // Деструктор
    void destroy()
    {
        this.Main = null
        this.length = 0
        this.deallocate()
    }
}