
struct Array
{
    private int Main
    
    private int size
    
    int array 

    // Конструктор
    static Array create(int size)
    {
        Array data = Array.allocate()
        data.Main = Main
        data.size = size
        return data
    }

    // Деструктор
    void destroy()
    {
        this.Main = null
        this.size = 0
        this.deallocate()
    }
}