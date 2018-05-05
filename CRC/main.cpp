#include <iostream>

using namespace std;

int SumaBinaria(int a, int b);

int main()
{
    int arr[9]{0,0,0,0,0,0,0,0};
    int ant[9]{0,0,0,0,0,0,0,0};
    while(1)
    {
        int s;
        cin>>s;

        arr[5]=SumaBinaria(ant[0],ant[1]);
        arr[6]=SumaBinaria(ant[0],ant[3]);
        arr[7]=SumaBinaria(ant[0],s);
        arr[8]=s;

        arr[0]=arr[5];
        arr[1]=ant[2];
        arr[2]=arr[6];
        arr[3]=ant[4];
        arr[4]=arr[7];

        for(int i=0; i<9; i++)
        {
            ant[i]=arr[i];
        }

        /*cout<<"\n";
        cout<<"Aneterior"<<"\n";
        for(int i=0; i<9; i++)
        {
            cout<<ant[i];
        }
        cout<<"\n";*/
        cout<<"Array"<<"\n";
        for(int i=0; i<9; i++)
        {
            cout<<arr[i];
        }
        cout<<"\n";
    }
}

int SumaBinaria(int a, int b)
{
    int res;
    if(a==0 && b==0) res=0;
    else if(a==0 && b==1) res=1;
    else if(a==1 && b==0) res=1;
    else res=0;
    return res;
}

void MostrarCodigo(int arr[])
{
    cout<<arr[0];
    cout<<arr[1];
    cout<<arr[2];
    cout<<arr[3];
    cout<<arr[4];
    cout<<arr[5];
    cout<<arr[6];
    cout<<arr[7];
    cout<<arr[8];
}