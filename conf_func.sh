function GetSec()
        {
            conf=$(echo $1)
            g_sec=`sed -n '/\[*\]/p' $conf  |grep -v '^#'|tr -d []`
            echo  "$g_sec"
        }
#注意：设置的key-value值中间的等号不能有空格 eg:key=value
#function Keylist()
#       {
#           l_sec=$(echo $1)
#           l_conf=$(echo $2)
#           sed -n '/\['$l_sec'\]/,/\[/p' $l_conf|grep -Ev '\[|\]|^$'|awk -F'=' '{print $1}'
#       }

function DelKey()
        {
            d_sec=$(echo $1)
            d_key=$(echo $2)
            d_conf=$(echo $3)
#可以删除无声明块的key-value(使用时不输入 m_sec 参数)，不会删除注释中的部分

  	    if [ -z "$d_conf" ]
            then
                d_conf=$d_key
                d_key=$d_sec
                sed -i '{:a;N;/\n\[/!{$!ba};s/\([\n]'$d_key'[=]\)[^\n]*//1}' $d_conf
            else
                sed -i '/\['$d_sec']/{:a;N;/\n\[/!{$!ba};s/\([\n]'$d_key'[=]\)[^\n]*//1}' $d_conf
            fi
                sed -i '/^$/d' $d_conf
                sed -i '/\[*\]/{x;p;x;}' $d_conf


#           sed -i '/\['$d_sec']/{:a;N;/\n\[/!{$!ba};s/\('$d_key'\)[^\n]*//1}' $d_conf
#           sed -i '/^$/d' $d_conf
#           sed -i '/\[*\]/{x;p;x;}' $d_conf
        }

function SetKey()
        {
            s_sec=$(echo $1)
            s_key=$(echo $2)
            s_value=$(echo $3)
            s_conf=$(echo $4)
            key_value="$s_key=$s_value"
#            if Keylist $s_sec $s_conf|grep "$s_key" >/dev/null
#            then
#                echo "$s_key already exists,please update $s_key"
#            else
#                sed -i "/^\[$s_sec\]/a$key_value" $s_conf
#            fi
            if [ "$s_sec" = "" ];
            then
                sed -i "1s/^/\n$key_value\n/" $s_conf
            else
                sed -i "/^\[$s_sec\]/a$key_value" $s_conf
            fi
#注释中的写法可以直接省略s_sec,而不是写""
#	    if [ -z "$m_conf" ];
#           then
#                m_conf=$m_value
#                m_value=$m_key
#                m_key=$m_sec
#                sed -i "1s/^/\n$key_value\n/" $s_conf
#            else
#                sed -i "/^\[$s_sec\]/a$key_value" $s_conf
#            fi

        }

function ModKey()
        {
            m_sec=$(echo $1)
            m_key=$(echo $2)
            m_value=$(echo $3) 
            m_conf=$(echo $4)
#解决注释中key-value修改问题，解决在无声明块的key-value修改问题(使用时不输入 m_sec 参数)
	    if [ -z "$m_conf" ];
            then
                m_conf=$m_value
                m_value=$m_key
                m_key=$m_sec
                sed -i '{:a;N;/\n\[/!{$!ba};s/\([\n]*'$m_key'\)[^\n]*/\1='$m_value'/1}' $m_conf
            else
                sed -i '/\['$m_sec']/{:a;N;/\n\[/!{$!ba};s/\([\n]*'$m_key'\)[^\n]*/\1='$m_value'/1}' $m_conf
            fi

            


            #sed -i '/\['$m_sec']/{:a;N;/\n\[/!{$!ba};s/\('$m_key'\)[^\n]*/\1='$m_value'/1}' $m_conf
        }
