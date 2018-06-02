import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Copyright © 2012-2025 云南红掌柜珠宝有限公司 版权所有
 * 文件名: MysqlSpecialChars.java
 * 类的详细说明
 *
 * @author smjie
 * @version 1.00
 * @Date 2018/5/15
 */
public class MysqlSpecialChars {
    private static final HashMap<String,String> sqlTokens;
    private static Pattern sqlTokenPattern;

    static
    {
        //MySQL escape sequences: http://dev.mysql.com/doc/refman/5.1/en/string-syntax.html
        String[][] search_regex_replacement = new String[][]
                {
                        //search string     search regex        sql replacement regex
                        {   "\u0000"    ,       "\\x00"     ,       "\\\\0"     },
                        {   "'"         ,       "'"         ,       "\\\\'"     },
                        {   "\""        ,       "\""        ,       "\\\\\""    },
                        {   "\b"        ,       "\\x08"     ,       "\\\\b"     },
                        {   "\n"        ,       "\\n"       ,       "\\\\n"     },
                        {   "\r"        ,       "\\r"       ,       "\\\\r"     },
                        {   "\t"        ,       "\\t"       ,       "\\\\t"     },
                        {   "\u001A"    ,       "\\x1A"     ,       "\\\\Z"     },
                        {   "/"         ,       "/"         ,       "//"        },
                        {   "\\"        ,       "\\\\"      ,       "\\\\\\\\"  }
                };

        sqlTokens = new HashMap<String,String>();
        String patternStr = "";
        for (String[] srr : search_regex_replacement)
        {
            sqlTokens.put(srr[0], srr[2]);
            patternStr += (patternStr.isEmpty() ? "" : "|") + srr[1];
        }
        sqlTokenPattern = Pattern.compile('(' + patternStr + ')');
    }


    public static String escape(String s)
    {
        Matcher matcher = sqlTokenPattern.matcher(s);
        StringBuffer sb = new StringBuffer();
        while(matcher.find())
        {
            matcher.appendReplacement(sb, sqlTokens.get(matcher.group(1)));
        }
        matcher.appendTail(sb);
        return sb.toString();
    }

    public static void main(String[] args) {
        String str = "2000\\条,dfgdfg,df.dfg,ertert'ert/ert";
        System.out.println("pre value:" + str + ", handle value:" + escape(str));
    }
}
