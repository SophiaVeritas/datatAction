//valac --pkg gio-2.0 dataAction02.vala

///This is useful for userClass to implement this framework
public interface dataface{
		public virtual void withData( ref dataAction dat) {print("dataface.withData()\n");}
		
		public virtual uint32 dataSize(){                     
            print("dataface.serializeSize()\n");
            return 0;
        }
}





public enum dataMode {NONE, SAVE, OPEN}
///Generic Single call - Multi User
///Goal: to minimize programmer serilization efforts and de-serilization, and reduce sequence errors if possible
public class dataAction: GLib.Object{
    public string filename;
    public uint8[] asData;
	public uint32 offset = 0;
    public dataMode mode;
    
    
    ///This is for use as in memory-transaction
    /// when we dont need to or want to use
    /// file I/O
    public dataAction(uint32 size){
        //Set to none - User will need to direct
        // Save or Open use for the data buffer
        mode = dataMode.NONE; 
		asData = new uint8[size];
	}
	
	public dataAction.OpenFile(string _filename){
        print ("opening started\n");
        mode = dataMode.OPEN;
        filename = _filename;
        
        try{
            var file = File.new_for_path (_filename);
            FileInfo info = file.query_info ("standard::size", 0);
            print("<%s> FileSize[ %"+int64.FORMAT+"]\n", _filename, info.get_size() );
            
            asData = new uint8[ info.get_size() ];
            
            var file_stream = file.read();
            var data_stream = new DataInputStream (file_stream);
            print ("Stream read\n");
            
            
            ///Load entire file all at once
            data_stream.read (asData);  
            
            print ("Data loaded\n");
            
        } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
       		return;
        }
   	 }
        
        
    
	public dataAction.forSave(string _filename, uint32 size){
        
        mode = dataMode.SAVE;
        filename = _filename;
        
        asData = new uint8[size];
    }
    
    public void writeToFile(){
        try {
            var file = File.new_for_path (filename);
            
            //delete if file already exists
            if (file.query_exists() ) {
                file.delete ();
            }
            
            var dos = new DataOutputStream (file.create (FileCreateFlags.REPLACE_DESTINATION));
            
            dos.write ( asData );
            
        } catch (Error e) {
            stderr.printf ("%s\n", e.message);
            return;
        }
    }
    
    
    
    
    
    public void as_char8 ( ref char val ){     
        uint32 bc = 1; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_uchar8 ( ref uchar val ){     
        uint32 bc = 1; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_unichar32 ( ref unichar val ){     
        uint32 bc = 4; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_int_32 ( ref int val ){     
        uint32 bc = 4; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_uint_32 ( ref uint val ){     
        uint32 bc = 4; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_long64 ( ref long val ){     
        uint32 bc = 8; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_ulong64 ( ref ulong val ){     
        uint32 bc = 8; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_short16 ( ref short val ){     
        uint32 bc = 2; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_ushort16 ( ref ushort val ){     
        uint32 bc = 2; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_float32 ( ref float val ){     
        uint32 bc = 4; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_double64 ( ref double val ){     
        uint32 bc = 8; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_bool32 ( ref bool val ){     
        uint32 bc = 2; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    /// Guaranteed-Size types (only ints?)
    
    public void as_int8 ( ref int8 val ){     
        uint32 bc = 1; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_int16 ( ref int16 val ){     
        uint32 bc = 2; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_int32 ( ref int32 val ){     
        uint32 bc = 4; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_int64 ( ref int64 val ){     
        uint32 bc = 8; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    // --- UNSIGNED Integers
    
    public void as_uint8 ( ref uint8 val ){     
        uint32 bc = 1; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_uint16 ( ref uint16 val ){     
        uint32 bc = 2; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_uint32 ( ref uint32 val ){     
        uint32 bc = 4; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
    public void as_uint64 ( ref uint64 val ){     
        uint32 bc = 8; ///Byte Count
        if (mode == dataMode.SAVE){
            Memory.copy ( &asData[offset], &val, bc);
        } else if (mode == dataMode.OPEN){
            Memory.copy (&val, &asData[offset], bc);
        }
        offset += bc;        
    }
    
/*  
    ///NOTE: string data size is not 32-bit (4-Byte), but the length of 
    ///     the string is a 32-bit integer, thus 32, at some point it may
    ///     get extended to length capable of 64-bit so for backwards 
    ///     compatiability from the future I set it here now.
*/
    public void as_string32 ( ref string val ){     
        
        if (mode == dataMode.SAVE){
            
            //Setup a temp variable that is the string length
            //NOTE: <string>.length = 32-bit integer
            uint32 len = val.length;
            
            //encode the string to a byte array
            uint8[] sdat = val.data; 
            
            
            
            ///Encode length of string, so when file reading
            ///  length of string is frist 4-bytes read
            ///  then reader will know how many bytes
            ///  string is long
            Memory.copy ( &asData[offset], &len, 4);
            offset += 4;
            
            
            ///Write the actual string bytes
            //Memory.copy ( &asData[offset], &sdat, len);
            Memory.copy ( &asData[offset], sdat, len);
            offset += len;
            
            
            
        } else if (mode == dataMode.OPEN){
            
            uint32 len = 0;
            
            
            
            ///Read 4-bytes and loat to int32 for length of string
            Memory.copy (&len, &asData[offset], 4);
            offset += 4;
            
            
            ///Now we know how big the string is so allocate a 
            ///temp buffer of that size
            uint8[] sdat = new uint8[len];
            
            
            
            ///Copy big buffer data to string buffer data
            Memory.copy (sdat, &asData[offset], len);
            offset += len;
            
            
            
            ///Last step is casting stringData back to string
            val = (string) sdat;  
        }
               
    }
    
          
    ~ dataAction(){
		if (asData != null)	asData = null;
	}
}






















/* Main
 *
 */
void main () {
    print("**** dataAction ... Sample 2                 ****\n");	
    print("* NOTE:                                         *\n");
    print("* This program saves a double to file, and      *\n");
    print("* loads the double back from the file.          *\n");
    print("*                                               *\n");
    print("*************************************************\n\n");

	
    ///Sample Variable 
    double d1 = 23;    
    int32 i1 = 11;
    string name1 = "its working";
    
    //Sample to read back into
    double d2 = 0;    
    int32 i2 = 0;
    string name2 = "none";
    
	///Save - file stuff
    //toData outFile = new toData(20);
    //NOTE: (Double = 8) + (int32 = 4) + (4 + string.length() )
    //NOTE II: The 4 needs to be added to each string it is the 32bit int holding the string length
 	dataAction myout = new dataAction.forSave("test_2.dat", 8+4+4+name1.length );
    
    ///Encapsulated data write
    ///NOTE: This sequence must mach exactly for the read to work
    myout.as_double64 ( ref d1 );
    myout.as_int32 ( ref i1 );
    myout.as_string32 ( ref name1 );
	
    
    ///Now with object data streamed - save to file
    myout.writeToFile();


/// 2nd Phase - TESTING
  
    ///Open - file stuff
    dataAction inFile = new dataAction.OpenFile("test_2.dat");    
    
    
    ///Encapuslated data Read
    ///Note: this sequence must match exactly the one for write, or you will load data into wrong elements
    inFile.as_double64( ref  d2);
    inFile.as_int32( ref  i2);
    inFile.as_string32( ref  name2);

    print ("Read back is %g, %d, %s\n", d2, i2, name2);
 
}



