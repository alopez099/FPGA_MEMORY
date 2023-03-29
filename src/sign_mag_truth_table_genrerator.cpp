//Get 2 adresses (a)0000_()1111 and perform signed magnigude addition and STORE result inside that adress 
//requires bit-masking in C++ 

#include <iostream> // includes the standard input/output stream library
#include <bitset> // includes the bitset class for bitwise operations
#include <cmath> // includes the math library for mathematical operations
#include <algorithm> // includes the algorithm library for the max and min functions
#include <fstream> // includes the file stream library for reading and writing files

using namespace std;

class Calc
{
public:
//// constant masks for the various bit operations that will be performed
        static const uint32_t A_SGN_8BIT_MASK = 0b00001000; 
        static const uint32_t A_MAG_8BIT_MASK = 0b00000111; 

        static const uint32_t B_SGN_8BIT_MASK = 0b10000000; 
        static const uint32_t B_MAG_8BIT_MASK = 0b01110000; 
        static const uint32_t R_MAG_8BIT_MASK = 0b00000111; 

        static const uint32_t A_SGN_16BIT_MASK = 0b0000000010000000; 
        static const uint32_t A_MAG_16BIT_MASK = 0b0000000001111111; 

        static const uint32_t B_SGN_16BIT_MASK = 0b1000000000000000; 
        static const uint32_t B_MAG_16BIT_MASK = 0b0111111100000000; 
        static const uint32_t R_MAG_16BIT_MASK = 0b0000000001111111;

        int addr_size; //the size of the address (8 or 16 bits)
        int data_size;// the size of the data (4 or 8 bits)
        uint32_t depth;

        ofstream truth_table_out; //ofstream is a C++ class defined in the <fstream> header file that is used for writing to files. It stands for "output file stream
        Calc(int addr_size)
        {
            this -> addr_size = addr_size;
            if (this-> addr_size != 8 && this-> addr_size != 16){
                throw std:: invalid_argument ("Only supports 8 and 16 bit adresses");
            }
            this-> data_size = (int)(addr_size /2);
            this-> depth = pow(2,addr_size);
            this->calculate();
        }
        uint32_t get_a_sgn(uint32_t val){
            return (val & (this-> addr_size == 8 ? A_SGN_8BIT_MASK : A_SGN_16BIT_MASK )) >> (this->data_size -1);
        }

        uint32_t get_a_mag(uint32_t val){
            return (val & (this-> addr_size == 8 ? A_MAG_8BIT_MASK : A_MAG_16BIT_MASK ));
        }

         uint32_t get_b_sgn(uint32_t val){
            return (val & (this-> addr_size == 8 ? B_SGN_8BIT_MASK : B_SGN_16BIT_MASK )) >> ((this->data_size *2 )-1);
        }
        uint32_t get_b_mag(uint32_t val){
            return (val & (this-> addr_size == 8 ? B_MAG_8BIT_MASK : B_MAG_16BIT_MASK )) >> (data_size);
        }
        uint32_t get_r_mag(uint32_t val){
            return val & (this ->addr_size == 8 ? R_MAG_8BIT_MASK : R_MAG_16BIT_MASK);
        }

        void calculate(){
            string file_name = "cpp_result_" + to_string(this->addr_size) + "_bit.txt";
            truth_table_out.open(file_name);

            for(uint32_t i=0; i < this ->depth; i++)
            {
                uint32_t a_sgn = this->get_a_sgn(i);
                uint32_t a_mag = this->get_a_mag(i);
                uint32_t b_sgn = this->get_b_sgn(i);
                uint32_t b_mag = this->get_b_mag(i);

                uint32_t r_mag;
                uint32_t r_sgn;

                //if the two operands have the same sign, add the mag and keep the sign
                if(a_sgn ==b_sgn)
                {
                    r_mag = a_mag + b_mag;
                    if(r_mag ==0)
                    {
                        r_sgn = 0;
                    }
                    else
                    {
                        r_sgn =a_sgn;
                    }
                }
                else
                {//if the 2 operands have differtent signs, subtract the smaller mag from the larger one 
                    r_mag = this->get_r_mag((max (a_mag,b_mag)-min(a_mag,b_mag)));
                    if(a_mag>b_mag)
                    {
                        r_mag = a_mag; //keep larger ones sign
                    }
                    else if (b_mag >a_mag){
                        r_mag = b_sgn;
                    }
                    else
                    {
                        r_sgn = 0;
                    }
                }
                if (this->addr_size ==8)
                {
                    truth_table_out << '"' << bitset<1>(r_sgn)
                                    << bitset<3>(r_mag)
                                    <<'"'<< ','
                                    << endl;
                }
                else
                {
                    truth_table_out << '"' << bitset<1>(r_sgn)
                                    << bitset<7>(r_mag)
                                    <<'"'<< ','
                                    << endl;
                }
            }//end for 
            truth_table_out.close();
        }
   
};

int main(){
    Calc calc_8(8);
    Calc calc_16(16);
    return 0;
}