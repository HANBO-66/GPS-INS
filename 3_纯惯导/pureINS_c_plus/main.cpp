#include "pro.h"

int main()
{
	// ����ת��ʵ��



	string filename1 = "../../../data/Data1.bin";
	string filename2 = "../../../data/Data1_PureINS.bin";
	if(!ins_process(filename1, filename2))
	{
		cout<<"error"<<endl;
		return 0;
	}

	return 1;

}