-- https://github.com/saadparwaiz1/cmp_luasnip
local os = require "os"
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix
local rep = require("luasnip.extras").rep

ls.cleanup()

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.setup({
    history = false,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = 'TextChanged, InsertLeave, TextChangedI',
    enable_autosnippets = true,
    region_check_events = 'CursorMoved',
})

local constr = function(index)
    return f(function(arg)
        if string.find(arg[1][1], ",") then
            ls = {}
            return_val = ""
            for substring in string.gmatch(arg[1][1], "[^,]+") do
                table.insert(ls, substring)
            end
            for _, i2 in ipairs(ls) do
                return_val = return_val .. "\n" .. i2
            end
            return return_val;
        else
            return arg[1][1]
        end
    end, {
        index,
    })
end

function all_trim(j)
    return j:match("^%s*(.-)%s*$")
end

local same_upper = function(index)
    return f(function(arg)
        argupper = string.upper(arg[1][1])
        return argupper
    end, {
        index,
    })
end

local same = function(index)
    return f(function(arg)
        return arg[1]
    end, {
        index,
    })
end

ls.add_snippets("c", { -- autosnippets
    s("^#inc", fmt("#include <{}>", {
        i(0, "default"),
    })),
}, {
    type = "autosnippets",
    key = "all_auto",
})

ls.add_snippets("c", {
    s("getInt", fmt([[
    {}
    ]], {
        c(1, {
            t({
                "int getInt() {",
                "   int x;",
                "   scanf(\"%d\", &x);",
                "   getchar();",
                "   return x;",
                "}",
            }),
            t({
                "int getInt(char prompt[]) {",
                "   int x;",
                "   printf(\"%s\", prompt);",
                "   scanf(\"%d\", &x);",
                "   getchar();",
                "   return x;",
                "}",
            }),
        }),
    })),
    s("readFile", fmt([[
void readFile(void) {{
    FILE *f;
    char line[{}];
    if ((f = fopen({}, "r")) == NULL) {{
        perror("Tiedoston avaaminen epäonnistui");
        exit(1);
    }}
    while (fgets(line, 30, f) != NULL) {{
        printf("%s", line);
    }}
    fclose(f);
    return;
}}{}
]], {
        i(1, "ALLOCATE"),
        i(2, "FILENAME"),
        i(0),
    })),
    s("getString", fmt([[
void getString(char *pString, int len) {{
    fgets(pString, len, stdin);         
    pString[strlen(pString) - 1] = '\0';
    return;
}}{}
]], {
        i(0),
    })),
    s("menu", fmt([[
int menu(void) {{
    int x;
    printf("{}");
    scanf("%d", &x);
    getchar();
    printf("\n");
    return x;
}}{}
]], {
        i(1),
        i(0),
    })),
    s("appendFile", fmt([[
void appendFile(char string[]) {{
    FILE *f;
    if ((f = fopen({}, "a")) == NULL) {{
        perror("Tiedoston avaaminen epäonnistui");
        exit(1);
    }}
    fprintf(f, "%s\n", string);
    fclose(f);
    return;
}}{}
]], {
        i(1, "FILENAME"),
        i(0),
    })),
    s("int main", fmt([[
int main ({}) {{
    {}
}}
]], {
        c(1, {
            t "void",
            t "int argc, char *argv[]",
        }),
        i(0),
    })),
    s("typedef struct", fmt([[
            typedef struct {} {{
        {}
    }} {};
    ]], {
        i(1, "<NAME>"),
        i(0),
        same_upper(1),
    })),
    s("if", fmt([[
        if ({}) {{
            {} 
        }}
        ]], {
        i(1, "<BOOLEAN>"),
        i(0),
    })),
    s("malloc", fmt([[
    if (({} = ({}){}({})) == NULL ) {{
        perror("Muistin varaus epäonnistui");
        exit(1);
    }}{}
    {}
    ]], {
        i(1, "<ADDRESS>"),
        i(2, "char*"),
        c(3, {
            t "malloc",
            t "realloc",
        }),
        i(4, "<MEM>"),
        i(0),
        d(5, function(args)
            if (args[2][1] == "realloc") then
                return sn(nil, {
                    i(3, ""),
                })
            end
            return sn(nil, fmt([[
            free({});
            ]], {
                i(1, args[1]),
            }))
        end, {
            1,
            3,
        }),
    })),
    s("for", fmt([[
    for ({}; {}; {}) {{
        {}
                    }}
    ]], {
        c(1, {
            t "i = 0",
            t "i = 1",
            i(1),
        }),
        i(2, "i < 10"),
        i(3, "i++"),
        i(0),
    })),
    s("fopen", fmt([[
    if (({} = fopen(FILENAME, "{}")) == NULL) {{
        perror("Tiedoston avaaminen epäonnistui");
        exit(1);
    }}{}
    ]], {
        c(1, {
            t "f",
            i(1),
        }),
        i(2),
        i(0),
    })),
})

ls.add_snippets("all", {
    s("curtime", f(function()
        return os.date "%D - %H:%M"
    end)),
})

ls.add_snippets("lua", {
    s("req", fmt("local {} = require('{}')", {
        i(1, "default"),
        rep(1),
    })),
})

ls.add_snippets("sh", {
    s("if", fmt([[
    if [ "{}" {} "{}" ]; then
        {}
    fi
    ]], {
        i(1, ""),
        i(2, "?"),
        i(3, ""),
        i(0),
    })),
})

ls.add_snippets("java", {
    s("cout", fmt([[
{}
    ]], {
        c(1, {
            sn(1, fmt([[System.out.println({});{}]], {
                i(1, "STRING"),
                i(0),
            })),
            sn(2, fmt([[System.out.print({});{}]], {
                i(1, "STRING"),
                i(0),
            })),
        }),
    })),
    s("cin", fmt([[
    {}
    ]], {
        c(1, {
            sn(1, fmt([[String {} = {}.nextLine();{}]], {
                i(1, "VAR"),
                i(2, "SCANNER"),
                i(0),
            })),
            sn(2, fmt([[int {} = Integer.valueOf({}.nextLine());{}]], {
                i(1, "VAR"),
                i(2, "SCANNER"),
                i(0),
            })),
            sn(2, fmt([[float {} = Float.valueOf({}.nextLine());{}]], {
                i(1, "VAR"),
                i(2, "SCANNER"),
                i(0),
            })),
            sn(2, fmt([[char {} = Character.valueOf({}.nextLine());{}]], {
                i(1, "VAR"),
                i(2, "SCANNER"),
                i(0),
            })),
        }),
    })),
    s("scan", fmt([[
Scanner {} = new Scanner(System.in);
    ]], {
        i(1, "VAR"),
    })),
    s("main", fmt([[
public class {} {{
    public static void main(String[] args) {{
        {}
    }}
}}
    ]], {
        i(1, "CLASS"),
        i(0),
    })),
    s("equals", fmt([[
    @Override
    public boolean equals(Object obj) {{
        if(this == obj) {{
            return true;
        }}
        if(obj == null) {{
            return false;
        }}
        if(obj.getClass() != {}.class) {{
            return false;
        }}
        {} obj_ = ({}) obj;
        return {};
    }}{}
    ]], {
        i(1, "CLASS"),
        same(1),
        same(1),
        i(2, "BOOLEAN"),
        i(0),
    })),
    s("array", fmt([[
ArrayList<{}> {};{}
    ]], {
        i(1, "Type"),
        i(2, "VAR"),
        i(0),
    })),
    s("classInvariant", fmt([[
    /**
        @.{} {}
    */{}
    ]], {
        c(1, {
            t({"classInvariant"}),
            t({"classInvariantPrivate"}),
            t({"classInvariantProtected"}),
        }),
        i(2, "CLASSINVARIANT"),
        i(0),
    })),
    s("pre", fmt([[
    /**
        {}
        @.pre {}
        @.post {}
    */{}
    ]], {
        i(1, "EXPLANATION"),
        i(2, "PRE"),
        i(3, "POST"),
        i(0),
    })),
    s("hash", fmt([[
HashMap<{}, {}> {};{}
    ]], {
        i(1, "KEY"),
        i(2, "VALUE"),
        i(3, "VAR"),
        i(0),
    })),
    s("builder", fmt([[
StringBuilder {}; {}
    ]], {
        i(1, "VAR"),
        i(0),
    })),
    s("readfile", fmt([[
        final String {} = "{}";
        File {} = new File({});
        try
            (Scanner {} = new Scanner({})) {{
            while({}.hasNextLine()) {{
                String line = {}.nextLine();
                {}
            }}
        }} catch(Exception e) {{
            System.out.println("Tapahtui virhe!\n");
            e.printStackTrace();
        }}
    ]], {
        i(1, "FILE"),
        i(2, "FILENAME"),
        i(3, "f"),
        same(1),
        i(4, "s"),
        same(3),
        same(4),
        same(4),
        i(0),
    })),
    s("constr", fmt([[
    {}
    public {}({}) {{
        {}
    }};{}

    {}
    ]], {
        d(5, function(args)
            if args[1][1] == "ARGS" then
                return sn(nil, fmt("", {}))
            end
            arg_table = {}
            sfmt = ""
            sargs = {}
            jump_index = 0
            for j in string.gmatch(args[1][1], "[^,?]+") do -- split on comma
                arg_name = string.match(j, "[^ ]+$") -- include only argument name
                arg_type = string.match(j, "[^ ].*[^A-ZÅÖÄa-zåöä_]") -- include only argument type
                if arg_name == nil or arg_type == nil or arg_name == "" or arg_type == "" then
                    break
                end
                arg_type = all_trim(arg_type)
                arg_name = all_trim(arg_name)
                j = all_trim(j)
                table.insert(arg_table, {
                    arg_type,
                    arg_name,
                    j,
                })
            end
            for _, j in ipairs(arg_table) do
                arg_type = j[1]
                arg_name = j[2]
                argument = j[3]
                first_char = string.sub(arg_name, 1, 1)
                rest_chars = string.sub(arg_name, 2)
                arg_name_up = string.upper(first_char) .. rest_chars -- i2 but first letter is uppercase
                sfmt = sfmt .. [[
                private {} {};]] .. "\n"
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_type))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_name))
            end
            return sn(nil, fmt(sfmt, sargs));
        end, {
            2, --  [1][1]
        }),
        i(1, "NAME"),
        i(2, "ARGS"),
        d(3, function(args)
            if args[1][1] == "ARGS" then
                return sn(nil, fmt("", {}))
            end
            ls = {}
            sfmt = ""
            sargs = {}
            jump_index = 0
            for name in string.gmatch(args[1][1], "[^,?]+") do -- split on comma
                name = string.match(name, "[^ ]+$") -- include only last word
                table.insert(ls, name)
            end
            for _, name in ipairs(ls) do
                sfmt = sfmt .. [[
                    this.{} = {};]] .. "\n" .. "    "
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, name))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, name))
            end
            return sn(nil, fmt(sfmt, sargs));
        end, {
            2, --  [1][1]
        }),
        i(0),
        d(4, function(args)
            if args[1][1] == "ARGS" then
                return sn(nil, fmt("", {}))
            end
            arg_table = {}
            sfmt = ""
            sargs = {}
            jump_index = 0
            for j in string.gmatch(args[1][1], "[^,?]+") do -- split on comma
                arg_name = string.match(j, "[^ ]+$") -- include only argument name
                arg_type = string.match(j, "[^ ].*[^A-ZÅÖÄa-zåöä_]") -- include only argument type
                if arg_name == nil or arg_type == nil or arg_name == "" or arg_type == "" then
                    break
                end
                arg_type = all_trim(arg_type)
                arg_name = all_trim(arg_name)
                table.insert(arg_table, {
                    arg_type,
                    arg_name,
                    j,
                })
            end
            for _, j in ipairs(arg_table) do
                arg_type = j[1]
                arg_name = j[2]
                argument = j[3]
                first_char = string.sub(arg_name, 1, 1)
                rest_chars = string.sub(arg_name, 2)
                arg_name_up = string.upper(first_char) .. rest_chars -- i2 but first letter is uppercase
                sfmt = sfmt .. [[
                public void set{}({}){{
                    this.{} = {};
                }}]] .. "\n\n" .. [[
                public {} get{}(){{
                    return this.{};
                }}]] .. "\n\n"
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_name_up))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, argument))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_name))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_name))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_type))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_name_up))
                jump_index = jump_index + 1
                table.insert(sargs, i(jump_index, arg_name))
            end
            return sn(nil, fmt(sfmt, sargs));
        end, {
            2, --  [1][1]
        }),
    })),
})

ls.add_snippets("rust", {
    s("read_stdin", fmt([[
        fn read_stdin<T: std::str::FromStr>() -> T {{
          let mut line = String::new();
          std::io::stdin().read_line(&mut line).unwrap();
          line.trim().parse().ok().unwrap()
        }}{}
    ]], {
        i(0),
    })),
    s("cout", fmt([[
        println!({});
    ]], {
        i(0),
    })),
    s("unused", fmt([[
        #![allow(unused)]{}
    ]], {
        i(0),
    })),
    s("derive Debug", fmt([[
        #[derive(Debug)]{}
    ]], {
        i(0),
    })),
    s("impl display", fmt([[
        impl std::fmt::Display for {} {{
            fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {{
                write!(f, {})
            }}
        }}
    ]], {
        i(1),
        i(0),
    })),
})
