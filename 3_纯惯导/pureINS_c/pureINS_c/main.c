//#include "pro.h"
#include "vec.h"
#include <string.h>


int main()
{
	char filename1[FILEMAX] = "../../data/Data1.bin";
	char filename2[FILEMAX] = "../../data/Data1_PureINS.bin";

	printf("ע����ļ�ʱ�������Ӧ���ǽ��ٶȼƺ������ǵ�����\n");
	printf("���ʱ�����Ƿ���ȷ\n");

	if(!ins_process(filename1, filename2, 1))
	{
		printf("error!\n");
		return 0;
	}
	
	return 1;

}