header
{
	using System.IO;
	using System.Globalization;

	using TokenStreamSelector		        = antlr.TokenStreamSelector;
}
options {
	language= "CSharp";
	namespace= "Parser";
}

class CSharpLexer extends Lexer;

options {
	importVocab= CSharpLexerBase;
	exportVocab= CSharpLexer;
	charVocabulary= '\u0000'..'\uFFFE';
	k= 3;
	testLiterals= false;
	defaultErrorHandler= false;
	codeGenMakeSwitchThreshold= 5;
	codeGenBitsetTestThreshold= 5;
	classHeaderSuffix= ICSharpLexer;
}

tokens										// MUST be kept in sync with "keywordsTable" Hashtable below!!
{
	ABSTRACT 		= "abstract";
	AS				= "as";
	BASE			= "base";
	BOOL			= "bool";
	BREAK			= "break";
	BYTE			= "byte";
	CASE			= "case";
	CATCH			= "catch";
	CHAR			= "char";
	CHECKED			= "checked";
	CLASS			= "class";
	CONST			= "const";
	CONTINUE		= "continue";
	DECIMAL			= "decimal";
//	DEFAULT			= "default";
	DELEGATE		= "delegate";
	DO				= "do";
	DOUBLE			= "double";
	ELSE			= "else";
	ENUM			= "enum";
	EVENT			= "event";
	EXPLICIT		= "explicit";
	EXTERN			= "extern";
//	FALSE			= "false";
	FINALLY			= "finally";
	FIXED			= "fixed";
	FLOAT			= "float";
	FOR				= "for";
	FOREACH			= "foreach";
	GOTO			= "goto";
	IF				= "if";
	IMPLICIT		= "implicit";
	IN				= "in";
	INT				= "int";
	INTERFACE		= "interface";
	INTERNAL		= "internal";
	IS				= "is";
	LOCK			= "lock";
	LONG			= "long";
	NAMESPACE		= "namespace";
	NEW				= "new";
	NULL			= "null";
	OBJECT			= "object";
	OPERATOR		= "operator";
	OUT				= "out";
	OVERRIDE		= "override";
	PARAMS			= "params";
	PRIVATE			= "private";
	PROTECTED		= "protected";
	PUBLIC			= "public";
	READONLY		= "readonly";
	REF				= "ref";
	RETURN			= "return";
	SBYTE			= "sbyte";
	SEALED			= "sealed";
	SHORT			= "short";
	SIZEOF			= "sizeof";
	STACKALLOC		= "stackalloc";
	STATIC			= "static";
	STRING			= "string";
	STRUCT			= "struct";
	SWITCH			= "switch";
	THIS			= "this";
	THROW			= "throw";
//	TRUE			= "true";
	TRY				= "try";
	TYPEOF			= "typeof";
	UINT			= "uint";
	ULONG			= "ulong";
	UNCHECKED		= "unchecked";
	UNSAFE			= "unsafe";
	USHORT			= "ushort";
	USING			= "using";
	VIRTUAL			= "virtual";
	VOID			= "void";
	VOLATILE		= "volatile";
	WHILE			= "while";
	VAR				= "var";

	DOT;
	UINT_LITERAL;
	LONG_LITERAL;
	ULONG_LITERAL;
	DECIMAL_LITERAL;
	FLOAT_LITERAL;
	DOUBLE_LITERAL;

	"add";
	"remove";
	"get";
	"set";
	"assembly";
	"field";
	"method";
	"module";
	"param";
	"property";
	"type";
}
{
	
	/// <summary>
	///   A <see cref="TokenStreamSelector"> for switching between this Lexer and the Preprocessor Lexer.
	/// </summary>
	private TokenStreamSelector selector_;
	
	/// <summary>
	///   A <see cref="TokenStreamSelector"> for switching between this Lexer and the Preprocessor Lexer.
	/// </summary>
	public TokenStreamSelector Selector
	{
		get { return selector_;  }
		set { selector_ = value; }
	}

	private FileInfo	_fileinfo = null;

	/// <summary>
	/// Update _fileinfo member whenever filename changes.
	/// </summary>
	public override void setFilename(string f)
	{
		base.setFilename(f);
		_fileinfo = new FileInfo(f);
	}
	
	/// <summary>
	///   Ensures all tokens have access to the source file's details.
	/// </summary>
	protected override IToken makeToken(int t)
	{
		IToken result = base.makeToken(t);
		CustomHiddenStreamToken customToken = result as CustomHiddenStreamToken;
		if ( customToken != null )
		{
			customToken.File = _fileinfo;
		}
		return result;
	}

	/// <summary>
	///   This table is used to keep a searchable list of keywords only. This is used mainly
	///   as for section "A.1.6 Identifers" for determining if an identifier is indeed a 
	///   VERBATIM_IDENTIFIER. It's contents MUST be kept in sync with the contents of section 
	///   "A.1.7 Keywords" above.
	/// </summary>
	///
	private static Hashtable keywordsTable = new Hashtable();
	
	static CSharpLexer()
	{
		keywordsTable.Add(ABSTRACT,  	"abstract");
		keywordsTable.Add(AS,        	"as");
		keywordsTable.Add(BASE,      	"base");
		keywordsTable.Add(BOOL,      	"bool");
		keywordsTable.Add(BREAK,     	"break");
		keywordsTable.Add(BYTE,      	"byte");
		keywordsTable.Add(CASE,      	"case");
		keywordsTable.Add(CATCH,     	"catch");
		keywordsTable.Add(CHAR,			"char");
		keywordsTable.Add(CHECKED,		"checked");
		keywordsTable.Add(CLASS,		"class");
		keywordsTable.Add(CONST,		"const");
		keywordsTable.Add(CONTINUE,		"continue");
		keywordsTable.Add(DECIMAL,		"decimal");
		keywordsTable.Add(DEFAULT,		"default");
		keywordsTable.Add(DELEGATE,		"delegate");
		keywordsTable.Add(DO,			"do");
		keywordsTable.Add(DOUBLE,		"double");
		keywordsTable.Add(ELSE,			"else");
		keywordsTable.Add(ENUM,			"enum");
		keywordsTable.Add(EVENT,		"event");
		keywordsTable.Add(EXPLICIT,		"explicit");
		keywordsTable.Add(EXTERN,		"extern");
		keywordsTable.Add(FALSE,		"false");
		keywordsTable.Add(FINALLY,		"finally");
		keywordsTable.Add(FIXED,		"fixed");
		keywordsTable.Add(FLOAT,		"float");
		keywordsTable.Add(FOR,			"for");
		keywordsTable.Add(FOREACH,		"foreach");
		keywordsTable.Add(GOTO,			"goto");
		keywordsTable.Add(IF,			"if");
		keywordsTable.Add(IMPLICIT,		"implicit");
		keywordsTable.Add(IN,			"in");
		keywordsTable.Add(INT,			"int");
		keywordsTable.Add(INTERFACE,	"interface");
		keywordsTable.Add(INTERNAL,		"internal");
		keywordsTable.Add(IS,			"is");
		keywordsTable.Add(LOCK,			"lock");
		keywordsTable.Add(LONG,			"long");
		keywordsTable.Add(NAMESPACE,	"namespace");
		keywordsTable.Add(NEW,			"new");
		keywordsTable.Add(NULL,			"null");
		keywordsTable.Add(OBJECT,		"object");
		keywordsTable.Add(OPERATOR,		"operator");
		keywordsTable.Add(OUT,			"out");
		keywordsTable.Add(OVERRIDE,		"override");
		keywordsTable.Add(PARAMS,		"params");
		keywordsTable.Add(PRIVATE,		"private");
		keywordsTable.Add(PROTECTED,	"protected");
		keywordsTable.Add(PUBLIC,		"public");
		keywordsTable.Add(READONLY,		"readonly");
		keywordsTable.Add(REF,			"ref");
		keywordsTable.Add(RETURN,		"return");
		keywordsTable.Add(SBYTE,		"sbyte");
		keywordsTable.Add(SEALED,		"sealed");
		keywordsTable.Add(SHORT,		"short");
		keywordsTable.Add(SIZEOF,		"sizeof");
		keywordsTable.Add(STACKALLOC,	"stackalloc");
		keywordsTable.Add(STATIC,		"static");
		keywordsTable.Add(STRING,		"string");
		keywordsTable.Add(STRUCT,		"struct");
		keywordsTable.Add(SWITCH,		"switch");
		keywordsTable.Add(THIS,			"this");
		keywordsTable.Add(THROW,		"throw");
		keywordsTable.Add(TRUE,			"true");
		keywordsTable.Add(TRY,			"try");
		keywordsTable.Add(TYPEOF,		"typeof");
		keywordsTable.Add(UINT,			"uint");
		keywordsTable.Add(ULONG,		"ulong");
		keywordsTable.Add(UNCHECKED,	"unchecked");
		keywordsTable.Add(UNSAFE,		"unsafe");
		keywordsTable.Add(USHORT,		"ushort");
		keywordsTable.Add(USING,		"using");
		keywordsTable.Add(VIRTUAL,		"virtual");
		keywordsTable.Add(VOID,			"void");
		keywordsTable.Add(WHILE,		"while");
		keywordsTable.Add(VAR,			"var");
	}
	
	public bool IsLetterCharacter(string s)
	{
		return ( (UnicodeCategory.LowercaseLetter == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Ll
		         (UnicodeCategory.ModifierLetter  == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lm
		         (UnicodeCategory.OtherLetter     == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lo
		         (UnicodeCategory.TitlecaseLetter == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lt
		         (UnicodeCategory.UppercaseLetter == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lu
		         (UnicodeCategory.LetterNumber    == Char.GetUnicodeCategory(s, 1))     //UNICODE class Nl
		        );
	}

	public bool IsIdentifierCharacter(string s)
	{
		return ( (UnicodeCategory.LowercaseLetter      == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Ll
		         (UnicodeCategory.ModifierLetter       == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lm
		         (UnicodeCategory.OtherLetter          == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lo
		         (UnicodeCategory.TitlecaseLetter      == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lt
		         (UnicodeCategory.UppercaseLetter      == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Lu
		         (UnicodeCategory.LetterNumber         == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Nl		         
		         (UnicodeCategory.NonSpacingMark       == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Mn		         
		         (UnicodeCategory.SpacingCombiningMark == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Mc
		         (UnicodeCategory.DecimalDigitNumber   == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Nd
		         (UnicodeCategory.ConnectorPunctuation == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Pc
		         (UnicodeCategory.Format               == Char.GetUnicodeCategory(s, 1))     //UNICODE class Cf
		        );
	}

	public bool IsCombiningCharacter(string s)
	{
		return ( (UnicodeCategory.NonSpacingMark       == Char.GetUnicodeCategory(s, 1)) ||  //UNICODE class Mn
		         (UnicodeCategory.SpacingCombiningMark == Char.GetUnicodeCategory(s, 1))     //UNICODE class Mc
		        );
	}
	
}
NEWLINE :( '\r' 									// MacOS-style newline
		  ( options { generateAmbigWarnings=false; } 
		    : '\n' 								// DOS/Windows style newline
		  )?
		| '\n'									// UNIX-style newline
		| '\u2028'								// UNICODE line separator
		| '\u2029'								// UNICODE paragraph separator
		)					
		{	newline(); 
		}
	;

WHITESPACE :pp1:PP_DIRECTIVE													
		{	if ( pp1.getColumn() == 1)
			{
				$setType(pp1.Type); 
				if ((pp1.Type == PP_REGION) || (pp1.Type == PP_ENDREGION) || (pp1.Type == PP_WARNING) || (pp1.Type == PP_ERROR))
					selector_.push("hooverLexer");
				else
					selector_.push("directivesLexer");
			}
			else
				$setType(PP_STRING); 
		} 
	|	nnw:NON_NEWLINE_WHITESPACE (NON_NEWLINE_WHITESPACE)*
		(	{ (nnw.getColumn() == 1) }? pp2:PP_DIRECTIVE 
			{	
				$setType(pp2.Type); 
				if ((pp2.Type == PP_REGION) || (pp2.Type == PP_ENDREGION) || (pp2.Type == PP_WARNING) || (pp2.Type == PP_ERROR))
					selector_.push("hooverLexer");
				else
					selector_.push("directivesLexer");
			}
		)?
	;

ML_COMMENT :"/*"
      ( options { generateAmbigWarnings=false; }		// ignore non-determinism on "*/" between me and block exit
        : { LA(2) != '/' }? '*'
      | NEWLINE					//{ newline(); }
      | ~( '*' | '\r' | '\n' | '\u2028' | '\u2029')		// ~( NEWLINE | '*' ) -- generated error
      )*
      "*/"                    //{ $setType(Token.SKIP); }
	;

IDENTIFIER 
options {
	testLiterals= true;
}
:'@' '"'						{ $setType(STRING_LITERAL);  }
	   ( ~( '"' )
	   | ('"' '"')
	   )*
	   '"'
	|  ( '@' )?
	   (
		 ( '_' 
	     | LETTER_CHARACTER
	     | { IsLetterCharacter(eseq.getText()) }? eseq:UNICODE_ESCAPE_SEQUENCE
	     ) 	     
	     ( LETTER_CHARACTER
	     | DECIMAL_DIGIT_CHARACTER
	     | CONNECTING_CHARACTER
	     | COMBINING_CHARACTER
	     | FORMATTING_CHARACTER
	     | { IsIdentifierCharacter(eseq2.getText()) }? eseq2:UNICODE_ESCAPE_SEQUENCE
	     )*
	   )
	;

INT_LITERAL :'0' ('x' | 'X') (HEX_DIGIT)+
	 	(	('l' | 'L')							{ $setType(LONG_LITERAL); } 
	    	( ('u' | 'U')						{ $setType(ULONG_LITERAL); } )?
	  	| 	('u' | 'U')							{ $setType(UINT_LITERAL); }
	    	( ('l' | 'L')						{ $setType(ULONG_LITERAL); } )?
	  	)?
	| 	'.' 									{ $setType(DOT); }
      	(	(DECIMAL_DIGIT)+					{ $setType(DOUBLE_LITERAL); }
        	( ('e'|'E') ('+'|'-')? (DECIMAL_DIGIT)+ )?
        	(	( 'f' | 'F' )					{ $setType(FLOAT_LITERAL); }
	     	|	( 'd' | 'D' )
	     	|	( 'm' | 'M' )					{ $setType(DECIMAL_LITERAL); }
	     	)?
      	)?
	|	(DECIMAL_DIGIT)+
	  	(	'.' (DECIMAL_DIGIT)+				{ $setType(DOUBLE_LITERAL); }
      		( ('e'|'E') ('+'|'-')? (DECIMAL_DIGIT)+ )?
      		(	( 'f' | 'F' )					{ $setType(FLOAT_LITERAL); }
     		|	( 'd' | 'D' )
     		|	( 'm' | 'M' )					{ $setType(DECIMAL_LITERAL); }
     		)?
	  	|	('e'|'E') ('+'|'-')? 
	  		(DECIMAL_DIGIT)+					{ $setType(DOUBLE_LITERAL); }
      		(	( 'f' | 'F' )					{ $setType(FLOAT_LITERAL); }
     		|	( 'd' | 'D' )
     		|	( 'm' | 'M' )					{ $setType(DECIMAL_LITERAL); }
     		)?
	  	|	(	( 'f' | 'F' )					{ $setType(FLOAT_LITERAL); }
	    	|	( 'd' | 'D' )					{ $setType(DOUBLE_LITERAL); }
	    	|	( 'm' | 'M' )					{ $setType(DECIMAL_LITERAL); }
	    	)
     	|	(	('l' | 'L')						{ $setType(LONG_LITERAL); } 
	     		( ('u' | 'U') 					{ $setType(ULONG_LITERAL); } )?
	   		|	('u' | 'U')						{ $setType(UINT_LITERAL); }
	     		( ('l' | 'L')					{ $setType(ULONG_LITERAL); } )?
	   		)
     	)?
	;

CHAR_LITERAL :'\''
		( ~( '\'' | '\\' | '\r' | '\n' | '\u2028' | '\u2029' )
		| ESCAPED_LITERAL
		)
		'\''
	;

STRING_LITERAL :'"'
	   ( ~( '"' | '\\' | '\r' | '\n' | '\u2028' | '\u2029' )
	   | ESCAPED_LITERAL
	   )*
	   '"'
	;

protected ESCAPED_LITERAL :'\\'
		( '\''
		| '"'
		| '\\'
		| '0'
		| 'a'
		| 'b'
		| 'f'
		| 'n'
		| 'r'
		| 't'
		| 'v'
		| 'x' HEX_DIGIT 
		      ( options { generateAmbigWarnings=false; } 
		        : HEX_DIGIT 
		          ( options { generateAmbigWarnings=false; } 
		            : HEX_DIGIT 
		              ( options { generateAmbigWarnings=false; } 
		                : HEX_DIGIT
		              )? 
		          )? 
		      )?
		)		
	| UNICODE_ESCAPE_SEQUENCE
	;

OPEN_CURLY :'{'		;

CLOSE_CURLY :'}'		;

OPEN_BRACK :'['		;

CLOSE_BRACK :']'		;

OPEN_PAREN :'('		;

CLOSE_PAREN :')'		;

COMMA :','		;

COLON :':'		;

SEMI :';'		;

PLUS :'+'		;

MINUS :'-'		;

STAR :'*'		;

DIV :'/'		;

MOD :'%'		;

BIN_AND :'&'		;

BIN_OR :'|'		;

BIN_XOR :'^'		;

LOG_NOT :'!'		;

BIN_NOT :'~'		;

ASSIGN :'='		;

LTHAN :'<'		;

GTHAN :'>'		;

QUESTION :'?'		;

INC :"++"		;

DEC :"--"		;

LOG_AND :"&&"		;

LOG_OR :"||"		;

SHIFTL :"<<"		;

SHIFTR :">>"		;

EQUAL :"=="		;

NOT_EQUAL :"!="		;

LTE :"<="		;

GTE :">="		;

PLUS_ASSIGN :"+="		;

MINUS_ASSIGN :"-="		;

STAR_ASSIGN :"*="		;

DIV_ASSIGN :"/="		;

MOD_ASSIGN :"%="		;

BIN_AND_ASSIGN :"&="		;

BIN_OR_ASSIGN :"|="		;

BIN_XOR_ASSIGN :"^="		;

SHIFTL_ASSIGN :"<<="		;

SHIFTR_ASSIGN :">>="		;

DEREF :"->"		;

protected PP_DIRECTIVE :'#' (NON_NEWLINE_WHITESPACE)*
		(	"define"									{ $setType(PP_DEFINE);		}
		| 	"undef"										{ $setType(PP_UNDEFINE);	}
		|	"if"										{ $setType(PP_COND_IF);		}
		| 	"line"										{ $setType(PP_LINE);      	}
		|	"error"										{ $setType(PP_ERROR);     	}
		| 	"warning"									{ $setType(PP_WARNING);   	}
		| 	"region"									{ $setType(PP_REGION);    	}
		| 	'e'
			(	'l'
				(	"se"								{ $setType(PP_COND_ELSE);  	}
				| 	"if"								{ $setType(PP_COND_ELIF);  	}
				)
			|	"nd"
				( 	"if"								{ $setType(PP_COND_ENDIF); 	}
				|	"region"							{ $setType(PP_ENDREGION);  	}
				)
			)
		)
	;

// inherited from grammar CSharpLexerBase
QUOTE :'"'		;

// inherited from grammar CSharpLexerBase
SL_COMMENT :"//" ( NOT_NEWLINE )* (NEWLINE)?
	;

// inherited from grammar CSharpLexerBase
protected NOT_NEWLINE :~( '\r' | '\n' | '\u2028' | '\u2029'	)
	;

// inherited from grammar CSharpLexerBase
protected NON_NEWLINE_WHITESPACE :'\t'			// horiz_tab
//	|	' '				// space -- commented out because UNICODE_CLASS_Zs contains space too
	| 	'\f'			// form_feed
	| 	'\u000B'		// '\u000B' == '\v' == vert_tab
	| 	UNICODE_CLASS_Zs	
	;

// inherited from grammar CSharpLexerBase
protected UNICODE_ESCAPE_SEQUENCE :'\\'
	   ( 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
	   | 'U' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
	   )
	;

// inherited from grammar CSharpLexerBase
protected DECIMAL_DIGIT :('0'..'9')
	;

// inherited from grammar CSharpLexerBase
protected HEX_DIGIT :('0'..'9'|'A'..'F'|'a'..'f')
	;

// inherited from grammar CSharpLexerBase
protected LETTER_CHARACTER :UNICODE_CLASS_Lu 
	|  UNICODE_CLASS_Ll 
	|  UNICODE_CLASS_Lt 
	|  UNICODE_CLASS_Lm 
	|  UNICODE_CLASS_Lo 
	|  UNICODE_CLASS_Nl
	;

// inherited from grammar CSharpLexerBase
protected DECIMAL_DIGIT_CHARACTER :UNICODE_CLASS_Nd
	;

// inherited from grammar CSharpLexerBase
protected CONNECTING_CHARACTER :UNICODE_CLASS_Pc
	;

// inherited from grammar CSharpLexerBase
protected COMBINING_CHARACTER :UNICODE_CLASS_Mn 
	|	UNICODE_CLASS_Mc
	;

// inherited from grammar CSharpLexerBase
protected FORMATTING_CHARACTER :UNICODE_CLASS_Cf
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Nl :( '\u16EE'..'\u16F0' 
		| '\u2160'..'\u2183'
		| '\u3007'..'\u3007'
		| '\u3021'..'\u3029'
		| '\u3038'..'\u303A'
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Lt :( '\u01C5' | '\u01C8' | '\u01CB' | '\u01F2' 
		| '\u1F88'..'\u1F8F' 
		| '\u1F98'..'\u1F9F' 
		| '\u1FA8'..'\u1FAF' 
		| '\u1FBC' | '\u1FCC' | '\u1FFC' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Zs :( '\u0020'
		| '\u00A0'
		| '\u1680'
		| '\u2000'..'\u200B'
		| '\u202F'
		| '\u205F'
		| '\u3000'
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Ll :( '\u0061'..'\u007A'
		| '\u00AA' | '\u00B5' | '\u00BA' 
		| '\u00DF'..'\u00F6'
		| '\u00F8'..'\u00FF'
		| '\u0101' | '\u0103' | '\u0105' | '\u0107' | '\u0109' | '\u010B' | '\u010D' | '\u010F' | '\u0111' 
		| '\u0113' | '\u0115' | '\u0117' | '\u0119' | '\u011B' | '\u011D' | '\u011F' | '\u0121' | '\u0123' 
		| '\u0125' | '\u0127' | '\u0129' | '\u012B' | '\u012D' | '\u012F' | '\u0131' | '\u0133' | '\u0135' 
		| '\u0137'..'\u0138' 
		| '\u013A' | '\u013C' | '\u013E' | '\u0140' | '\u0142' | '\u0144' | '\u0146' 
		| '\u0148'..'\u0149' 
		| '\u014B' | '\u014D' | '\u014F' | '\u0151' | '\u0153' | '\u0155' | '\u0157' | '\u0159' | '\u015B' 
		| '\u015D' | '\u015F' | '\u0161' | '\u0163' | '\u0165' | '\u0167' | '\u0169' | '\u016B' | '\u016D' 
		| '\u016F' | '\u0171' | '\u0173' | '\u0175' | '\u0177' | '\u017A' | '\u017C' 
		| '\u017E'..'\u0180' 
		| '\u0183' | '\u0185' | '\u0188' 
		| '\u018C'..'\u018D' 
		| '\u0192' | '\u0195' 
		| '\u0199'..'\u019B' 
		| '\u019E' | '\u01A1' | '\u01A3' | '\u01A5' | '\u01A8' 
		| '\u01AA'..'\u01AB' 
		| '\u01AD' | '\u01B0' | '\u01B4' | '\u01B6' 
		| '\u01B9'..'\u01BA' 
		| '\u01BD'..'\u01BF' 
		| '\u01C6' | '\u01C9' | '\u01CC' | '\u01CE' | '\u01D0' | '\u01D2' | '\u01D4' | '\u01D6' | '\u01D8' 
		| '\u01DA' 
		| '\u01DC'..'\u01DD' 
		| '\u01DF' | '\u01E1' | '\u01E3' | '\u01E5' | '\u01E7' | '\u01E9' | '\u01EB' | '\u01ED' 
		| '\u01EF'..'\u01F0' 
		| '\u01F3' | '\u01F5' | '\u01F9' | '\u01FB' | '\u01FD' | '\u01FF' | '\u0201' | '\u0203' | '\u0205' 
		| '\u0207' | '\u0209' | '\u020B' | '\u020D' | '\u020F' | '\u0211' | '\u0213' | '\u0215' | '\u0217' 
		| '\u0219' | '\u021B' | '\u021D' | '\u021F' | '\u0223' | '\u0225' | '\u0227' | '\u0229' | '\u022B' 
		| '\u022D' | '\u022F' | '\u0231' | '\u0233' 
		| '\u0250'..'\u02AD' 
		| '\u0390' 
		| '\u03AC'..'\u03CE' 
		| '\u03D0'..'\u03D1' 
		| '\u03D5'..'\u03D7' 
		| '\u03D9' | '\u03DB' | '\u03DD' | '\u03DF' | '\u03E1' | '\u03E3' | '\u03E5' | '\u03E7' | '\u03E9' 
		| '\u03EB' | '\u03ED' 
		| '\u03EF'..'\u03F3' 
		| '\u03F5' 
		| '\u0430'..'\u045F' 
		| '\u0461' | '\u0463' | '\u0465'	| '\u0467' | '\u0469' | '\u046B' | '\u046D' | '\u046F' | '\u0471' 
		| '\u0473' | '\u0475' | '\u0477' | '\u0479' | '\u047B' | '\u047D' | '\u047F' | '\u0481' | '\u048B' 
		| '\u048D' | '\u048F' | '\u0491' | '\u0493' | '\u0495' | '\u0497' | '\u0499' | '\u049B' | '\u049D' 
		| '\u049F' | '\u04A1' | '\u04A3' | '\u04A5' | '\u04A7' | '\u04A9' | '\u04AB' | '\u04AD' | '\u04AF' 
		| '\u04B1' | '\u04B3' | '\u04B5' | '\u04B7' | '\u04B9' | '\u04BB' | '\u04BD' | '\u04BF' | '\u04C2' 
		| '\u04C4' | '\u04C6' | '\u04C8' | '\u04CA' | '\u04CC' | '\u04CE' | '\u04D1' | '\u04D3' | '\u04D5' 
		| '\u04D7' | '\u04D9' | '\u04DB' | '\u04DD' | '\u04DF' | '\u04E1' | '\u04E3' | '\u04E5' | '\u04E7' 
		| '\u04E9' | '\u04EB' | '\u04ED' | '\u04EF' | '\u04F1' | '\u04F3' | '\u04F5' | '\u04F9' | '\u0501' 
		| '\u0503' | '\u0505' | '\u0507' | '\u0509' | '\u050B' | '\u050D' | '\u050F' 
		| '\u0561'..'\u0587' 
		| '\u1E01' | '\u1E03' | '\u1E05' | '\u1E07' | '\u1E09' | '\u1E0B' | '\u1E0D' | '\u1E0F' | '\u1E11' 
		| '\u1E13' | '\u1E15' | '\u1E17' | '\u1E19' | '\u1E1B' | '\u1E1D' | '\u1E1F' | '\u1E21' | '\u1E23' 
		| '\u1E25' | '\u1E27' | '\u1E29' | '\u1E2B' | '\u1E2D' | '\u1E2F' | '\u1E31' | '\u1E33' | '\u1E35' 
		| '\u1E37' | '\u1E39' | '\u1E3B' | '\u1E3D' | '\u1E3F' | '\u1E41' | '\u1E43' | '\u1E45' | '\u1E47' 
		| '\u1E49' | '\u1E4B' | '\u1E4D' | '\u1E4F' | '\u1E51' | '\u1E53' | '\u1E55' | '\u1E57' | '\u1E59' 
		| '\u1E5B' | '\u1E5D' | '\u1E5F' | '\u1E61' | '\u1E63' | '\u1E65' | '\u1E67' | '\u1E69' | '\u1E6B' 
		| '\u1E6D' | '\u1E6F' | '\u1E71' | '\u1E73' | '\u1E75' | '\u1E77' | '\u1E79' | '\u1E7B' | '\u1E7D' 
		| '\u1E7F' | '\u1E81' | '\u1E83' | '\u1E85' | '\u1E87' | '\u1E89' | '\u1E8B' | '\u1E8D' | '\u1E8F' 
		| '\u1E91' | '\u1E93' 
		| '\u1E95'..'\u1E9B' 
		| '\u1EA1' | '\u1EA3' | '\u1EA5' | '\u1EA7' | '\u1EA9' | '\u1EAB' | '\u1EAD' | '\u1EAF' | '\u1EB1' 
		| '\u1EB3' | '\u1EB5' | '\u1EB7' | '\u1EB9' | '\u1EBB' | '\u1EBD' | '\u1EBF' | '\u1EC1' | '\u1EC3' 
		| '\u1EC5' | '\u1EC7' | '\u1EC9' | '\u1ECB' | '\u1ECD' | '\u1ECF' | '\u1ED1' | '\u1ED3' | '\u1ED5' 
		| '\u1ED7' | '\u1ED9' | '\u1EDB' | '\u1EDD' | '\u1EDF' | '\u1EE1' | '\u1EE3' | '\u1EE5' | '\u1EE7' 
		| '\u1EE9' | '\u1EEB' | '\u1EED' | '\u1EEF' | '\u1EF1' | '\u1EF3' | '\u1EF5' | '\u1EF7' | '\u1EF9' 
		| '\u1F00'..'\u1F07' 
		| '\u1F10'..'\u1F15' 
		| '\u1F20'..'\u1F27' 
		| '\u1F30'..'\u1F37' 
		| '\u1F40'..'\u1F45' 
		| '\u1F50'..'\u1F57' 
		| '\u1F60'..'\u1F67' 
		| '\u1F70'..'\u1F7D' 
		| '\u1F80'..'\u1F87' 
		| '\u1F90'..'\u1F97' 
		| '\u1FA0'..'\u1FA7' 
		| '\u1FB0'..'\u1FB4' 
		| '\u1FB6'..'\u1FB7' 
		| '\u1FBE' 
		| '\u1FC2'..'\u1FC4' 
		| '\u1FC6'..'\u1FC7' 
		| '\u1FD0'..'\u1FD3' 
		| '\u1FD6'..'\u1FD7' 
		| '\u1FE0'..'\u1FE7' 
		| '\u1FF2'..'\u1FF4' 
		| '\u1FF6'..'\u1FF7' 
		| '\u2071' | '\u207F' | '\u210A' 
		| '\u210E'..'\u210F' 
		| '\u2113' | '\u212F' | '\u2134' | '\u2139' | '\u213D' 
		| '\u2146'..'\u2149' 
		| '\uFB00'..'\uFB06' 
		| '\uFB13'..'\uFB17' 
		| '\uFF41'..'\uFF5A' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Lu :( '\u0041'..'\u005A' 
		| '\u00C0'..'\u00D6' 
		| '\u00D8'..'\u00DE' 
		| '\u0100' | '\u0102' | '\u0104' | '\u0106' | '\u0108' | '\u010A' | '\u010C' | '\u010E' | '\u0110' 
		| '\u0112' | '\u0114' | '\u0116' | '\u0118' | '\u011A' | '\u011C' | '\u011E' | '\u0120' | '\u0122' 
		| '\u0124' | '\u0126' | '\u0128' | '\u012A' | '\u012C' | '\u012E' | '\u0130' | '\u0132' | '\u0134' 
		| '\u0136' | '\u0139' | '\u013B' | '\u013D' | '\u013F' | '\u0141' | '\u0143' | '\u0145' | '\u0147' 
		| '\u014A' | '\u014C' | '\u014E' | '\u0150' | '\u0152' | '\u0154' | '\u0156' | '\u0158' | '\u015A' 
		| '\u015C' | '\u015E' | '\u0160' | '\u0162' | '\u0164' | '\u0166' | '\u0168' | '\u016A' | '\u016C' 
		| '\u016E' | '\u0170' | '\u0172' | '\u0174' | '\u0176' 
		| '\u0178'..'\u0179' 
		| '\u017B' | '\u017D' 
		| '\u0181'..'\u0182' 
		| '\u0184' 
		| '\u0186'..'\u0187' 
		| '\u0189'..'\u018B' 
		| '\u018E'..'\u0191' 
		| '\u0193'..'\u0194' 
		| '\u0196'..'\u0198' 
		| '\u019C'..'\u019D' 
		| '\u019F'..'\u01A0' 
		| '\u01A2' | '\u01A4' 
		| '\u01A6'..'\u01A7' 
		| '\u01A9' | '\u01AC' 
		| '\u01AE'..'\u01AF' 
		| '\u01B1'..'\u01B3' 
		| '\u01B5' 
		| '\u01B7'..'\u01B8' 
		| '\u01BC' | '\u01C4' | '\u01C7' | '\u01CA' | '\u01CD' | '\u01CF' | '\u01D1' | '\u01D3' | '\u01D5' 
		| '\u01D7' | '\u01D9' | '\u01DB' | '\u01DE' | '\u01E0' | '\u01E2' | '\u01E4' | '\u01E6' | '\u01E8' 
		| '\u01EA' | '\u01EC' | '\u01EE' | '\u01F1' | '\u01F4' 
		| '\u01F6'..'\u01F8' 
		| '\u01FA' | '\u01FC' | '\u01FE' | '\u0200' | '\u0202' | '\u0204' | '\u0206' | '\u0208' | '\u020A' 
		| '\u020C' | '\u020E' | '\u0210' | '\u0212' | '\u0214' | '\u0216' | '\u0218' | '\u021A' | '\u021C' 
		| '\u021E' | '\u0220' | '\u0222' | '\u0224' | '\u0226' | '\u0228' | '\u022A' | '\u022C' | '\u022E' 
		| '\u0230' | '\u0232' | '\u0386' 
		| '\u0388'..'\u038A' 
		| '\u038C' 
		| '\u038E'..'\u038F' 
		| '\u0391'..'\u03A1' 
		| '\u03A3'..'\u03AB' 
		| '\u03D2'..'\u03D4' 
		| '\u03D8' | '\u03DA' | '\u03DC' | '\u03DE' | '\u03E0' | '\u03E2' | '\u03E4' | '\u03E6' | '\u03E8' 
		| '\u03EA' | '\u03EC' | '\u03EE' | '\u03F4' 
		| '\u0400'..'\u042F' 
		| '\u0460' | '\u0462' | '\u0464' | '\u0466' | '\u0468' | '\u046A' | '\u046C' | '\u046E' | '\u0470' 
		| '\u0472' | '\u0474' | '\u0476' | '\u0478' | '\u047A' | '\u047C' | '\u047E' | '\u0480' | '\u048A' 
		| '\u048C' | '\u048E' | '\u0490' | '\u0492' | '\u0494' | '\u0496' | '\u0498' | '\u049A' | '\u049C' 
		| '\u049E' | '\u04A0' | '\u04A2' | '\u04A4' | '\u04A6' | '\u04A8' | '\u04AA' | '\u04AC' | '\u04AE' 
		| '\u04B0' | '\u04B2' | '\u04B4' | '\u04B6' | '\u04B8' | '\u04BA' | '\u04BC' | '\u04BE' 
		| '\u04C0'..'\u04C1' 
		| '\u04C3' | '\u04C5' | '\u04C7' | '\u04C9' | '\u04CB' | '\u04CD' | '\u04D0' | '\u04D2' | '\u04D4' 
		| '\u04D6' | '\u04D8' | '\u04DA' | '\u04DC' | '\u04DE' | '\u04E0' | '\u04E2' | '\u04E4' | '\u04E6' 
		| '\u04E8' | '\u04EA' | '\u04EC' | '\u04EE' | '\u04F0' | '\u04F2' | '\u04F4' | '\u04F8' | '\u0500' 
		| '\u0502' | '\u0504' | '\u0506' | '\u0508' | '\u050A' | '\u050C' | '\u050E' 
		| '\u0531'..'\u0556' 
		| '\u10A0'..'\u10C5' 
		| '\u1E00' | '\u1E02' | '\u1E04' | '\u1E06' | '\u1E08' | '\u1E0A' | '\u1E0C' | '\u1E0E' | '\u1E10' 
		| '\u1E12' | '\u1E14' | '\u1E16' | '\u1E18' | '\u1E1A' | '\u1E1C' | '\u1E1E' | '\u1E20' | '\u1E22' 
		| '\u1E24' | '\u1E26' | '\u1E28' | '\u1E2A' | '\u1E2C' | '\u1E2E' | '\u1E30' | '\u1E32' | '\u1E34' 
		| '\u1E36' | '\u1E38' | '\u1E3A' | '\u1E3C' | '\u1E3E' | '\u1E40' | '\u1E42' | '\u1E44' | '\u1E46' 
		| '\u1E48' | '\u1E4A' | '\u1E4C' | '\u1E4E' | '\u1E50' | '\u1E52' | '\u1E54' | '\u1E56' | '\u1E58' 
		| '\u1E5A' | '\u1E5C' | '\u1E5E' | '\u1E60' | '\u1E62' | '\u1E64' | '\u1E66' | '\u1E68' | '\u1E6A' 
		| '\u1E6C' | '\u1E6E' | '\u1E70' | '\u1E72' | '\u1E74' | '\u1E76' | '\u1E78' | '\u1E7A' | '\u1E7C' 
		| '\u1E7E' | '\u1E80' | '\u1E82' | '\u1E84' | '\u1E86' | '\u1E88' | '\u1E8A' | '\u1E8C' | '\u1E8E' 
		| '\u1E90' | '\u1E92' | '\u1E94' | '\u1EA0' | '\u1EA2' | '\u1EA4' | '\u1EA6' | '\u1EA8' | '\u1EAA' 
		| '\u1EAC' | '\u1EAE' | '\u1EB0' | '\u1EB2' | '\u1EB4' | '\u1EB6' | '\u1EB8' | '\u1EBA' | '\u1EBC' 
		| '\u1EBE' | '\u1EC0' | '\u1EC2' | '\u1EC4' | '\u1EC6' | '\u1EC8' | '\u1ECA' | '\u1ECC' | '\u1ECE' 
		| '\u1ED0' | '\u1ED2' | '\u1ED4' | '\u1ED6' | '\u1ED8' | '\u1EDA' | '\u1EDC' | '\u1EDE' | '\u1EE0' 
		| '\u1EE2' | '\u1EE4' | '\u1EE6' | '\u1EE8' | '\u1EEA' | '\u1EEC' | '\u1EEE' | '\u1EF0' | '\u1EF2' 
		| '\u1EF4' | '\u1EF6' | '\u1EF8' 
		| '\u1F08'..'\u1F0F'  
		| '\u1F18'..'\u1F1D' 
		| '\u1F28'..'\u1F2F' 
		| '\u1F38'..'\u1F3F' 
		| '\u1F48'..'\u1F4D' 
		| '\u1F59' | '\u1F5B' | '\u1F5D' | '\u1F5F' 
		| '\u1F68'..'\u1F6F' 
		| '\u1FB8'..'\u1FBB' 
		| '\u1FC8'..'\u1FCB' 
		| '\u1FD8'..'\u1FDB' 
		| '\u1FE8'..'\u1FEC' 
		| '\u1FF8'..'\u1FFB' 
		| '\u2102' | '\u2107' 
		| '\u210B'..'\u210D' 
		| '\u2110'..'\u2112' 
		| '\u2115' 
		| '\u2119'..'\u211D' 
		| '\u2124' | '\u2126' | '\u2128' 
		| '\u212A'..'\u212D' 
		| '\u2130'..'\u2131' 
		| '\u2133' 
		| '\u213E'..'\u213F' 
		| '\u2145' 
		| '\uFF21'..'\uFF3A' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Lo :( '\u01BB' 
		| '\u01C0'..'\u01C3' 
		| '\u05D0'..'\u05EA' 
		| '\u05F0'..'\u05F2' 
		| '\u0621'..'\u063A' 
		| '\u0641'..'\u064A' 
		| '\u066E'..'\u066F' 
		| '\u0671'..'\u06D3' 
		| '\u06D5' 
		| '\u06FA'..'\u06FC' 
		| '\u0710' 
		| '\u0712'..'\u072C' 
		| '\u0780'..'\u07A5' 
		| '\u07B1' 
		| '\u0905'..'\u0939' 
		| '\u093D' | '\u0950' 
		| '\u0958'..'\u0961' 
		| '\u0985'..'\u098C' 
		| '\u098F'..'\u0990' 
		| '\u0993'..'\u09A8' 
		| '\u09AA'..'\u09B0' 
		| '\u09B2' 
		| '\u09B6'..'\u09B9' 
		| '\u09DC'..'\u09DD' 
		| '\u09DF'..'\u09E1' 
		| '\u09F0'..'\u09F1' 
		| '\u0A05'..'\u0A0A' 
		| '\u0A0F'..'\u0A10' 
		| '\u0A13'..'\u0A28' 
		| '\u0A2A'..'\u0A30' 
		| '\u0A32'..'\u0A33' 
		| '\u0A35'..'\u0A36' 
		| '\u0A38'..'\u0A39' 
		| '\u0A59'..'\u0A5C' 
		| '\u0A5E' 
		| '\u0A72'..'\u0A74' 
		| '\u0A85'..'\u0A8B' 
		| '\u0A8D' 
		| '\u0A8F'..'\u0A91' 
		| '\u0A93'..'\u0AA8' 
		| '\u0AAA'..'\u0AB0' 
		| '\u0AB2'..'\u0AB3' 
		| '\u0AB5'..'\u0AB9' 
		| '\u0ABD' | '\u0AD0' | '\u0AE0' 
		| '\u0B05'..'\u0B0C' 
		| '\u0B0F'..'\u0B10' 
		| '\u0B13'..'\u0B28' 
		| '\u0B2A'..'\u0B30' 
		| '\u0B32'..'\u0B33' 
		| '\u0B36'..'\u0B39' 
		| '\u0B3D' 
		| '\u0B5C'..'\u0B5D' 
		| '\u0B5F'..'\u0B61' 
		| '\u0B83' 
		| '\u0B85'..'\u0B8A' 
		| '\u0B8E'..'\u0B90' 
		| '\u0B92'..'\u0B95' 
		| '\u0B99'..'\u0B9A' 
		| '\u0B9C' 
		| '\u0B9E'..'\u0B9F' 
		| '\u0BA3'..'\u0BA4' 
		| '\u0BA8'..'\u0BAA' 
		| '\u0BAE'..'\u0BB5' 
		| '\u0BB7'..'\u0BB9' 
		| '\u0C05'..'\u0C0C' 
		| '\u0C0E'..'\u0C10' 
		| '\u0C12'..'\u0C28' 
		| '\u0C2A'..'\u0C33' 
		| '\u0C35'..'\u0C39' 
		| '\u0C60'..'\u0C61' 
		| '\u0C85'..'\u0C8C' 
		| '\u0C8E'..'\u0C90' 
		| '\u0C92'..'\u0CA8' 
		| '\u0CAA'..'\u0CB3' 
		| '\u0CB5'..'\u0CB9' 
		| '\u0CDE' 
		| '\u0CE0'..'\u0CE1' 
		| '\u0D05'..'\u0D0C' 
		| '\u0D0E'..'\u0D10' 
		| '\u0D12'..'\u0D28' 
		| '\u0D2A'..'\u0D39' 
		| '\u0D60'..'\u0D61' 
		| '\u0D85'..'\u0D96' 
		| '\u0D9A'..'\u0DB1' 
		| '\u0DB3'..'\u0DBB' 
		| '\u0DBD' 
		| '\u0DC0'..'\u0DC6' 
		| '\u0E01'..'\u0E30' 
		| '\u0E32'..'\u0E33' 
		| '\u0E40'..'\u0E45' 
		| '\u0E81'..'\u0E82' 
		| '\u0E84' 
		| '\u0E87'..'\u0E88' 
		| '\u0E8A' | '\u0E8D' 
		| '\u0E94'..'\u0E97' 
		| '\u0E99'..'\u0E9F' 
		| '\u0EA1'..'\u0EA3' 
		| '\u0EA5' | '\u0EA7' 
		| '\u0EAA'..'\u0EAB' 
		| '\u0EAD'..'\u0EB0' 
		| '\u0EB2'..'\u0EB3' 
		| '\u0EBD' 
		| '\u0EC0'..'\u0EC4' 
		| '\u0EDC'..'\u0EDD' 
		| '\u0F00' 
		| '\u0F40'..'\u0F47' 
		| '\u0F49'..'\u0F6A' 
		| '\u0F88'..'\u0F8B' 
		| '\u1000'..'\u1021' 
		| '\u1023'..'\u1027' 
		| '\u1029'..'\u102A' 
		| '\u1050'..'\u1055' 
		| '\u10D0'..'\u10F8' 
		| '\u1100'..'\u1159' 
		| '\u115F'..'\u11A2' 
		| '\u11A8'..'\u11F9' 
		| '\u1200'..'\u1206' 
		| '\u1208'..'\u1246' 
		| '\u1248' 
		| '\u124A'..'\u124D' 
		| '\u1250'..'\u1256' 
		| '\u1258' 
		| '\u125A'..'\u125D' 
		| '\u1260'..'\u1286' 
		| '\u1288' 
		| '\u128A'..'\u128D' 
		| '\u1290'..'\u12AE' 
		| '\u12B0' 
		| '\u12B2'..'\u12B5' 
		| '\u12B8'..'\u12BE' 
		| '\u12C0' 
		| '\u12C2'..'\u12C5' 
		| '\u12C8'..'\u12CE' 
		| '\u12D0'..'\u12D6' 
		| '\u12D8'..'\u12EE' 
		| '\u12F0'..'\u130E' 
		| '\u1310' 
		| '\u1312'..'\u1315' 
		| '\u1318'..'\u131E' 
		| '\u1320'..'\u1346' 
		| '\u1348'..'\u135A' 
		| '\u13A0'..'\u13F4' 
		| '\u1401'..'\u166C' 
		| '\u166F'..'\u1676' 
		| '\u1681'..'\u169A' 
		| '\u16A0'..'\u16EA' 
		| '\u1700'..'\u170C' 
		| '\u170E'..'\u1711' 
		| '\u1720'..'\u1731' 
		| '\u1740'..'\u1751' 
		| '\u1760'..'\u176C' 
		| '\u176E'..'\u1770' 
		| '\u1780'..'\u17B3' 
		| '\u17DC' 
		| '\u1820'..'\u1842' 
		| '\u1844'..'\u1877' 
		| '\u1880'..'\u18A8' 
		| '\u2135'..'\u2138' 
		| '\u3006' | '\u303C' 
		| '\u3041'..'\u3096' 
		| '\u309F' 
		| '\u30A1'..'\u30FA' 
		| '\u30FF' 
		| '\u3105'..'\u312C' 
		| '\u3131'..'\u318E' 
		| '\u31A0'..'\u31B7' 
		| '\u31F0'..'\u31FF' 
		| '\u3400' | '\u4DB5' | '\u4E00' | '\u9FA5' 
		| '\uA000'..'\uA48C' 
		| '\uAC00' | '\uD7A3' 
		| '\uF900'..'\uFA2D' 
		| '\uFA30'..'\uFA6A' 
		| '\uFB1D' 
		| '\uFB1F'..'\uFB28' 
		| '\uFB2A'..'\uFB36' 
		| '\uFB38'..'\uFB3C' 
		| '\uFB3E' 
		| '\uFB40'..'\uFB41' 
		| '\uFB43'..'\uFB44' 
		| '\uFB46'..'\uFBB1' 
		| '\uFBD3'..'\uFD3D' 
		| '\uFD50'..'\uFD8F' 
		| '\uFD92'..'\uFDC7' 
		| '\uFDF0'..'\uFDFB' 
		| '\uFE70'..'\uFE74' 
		| '\uFE76'..'\uFEFC' 
		| '\uFF66'..'\uFF6F' 
		| '\uFF71'..'\uFF9D' 
		| '\uFFA0'..'\uFFBE' 
		| '\uFFC2'..'\uFFC7' 
		| '\uFFCA'..'\uFFCF' 
		| '\uFFD2'..'\uFFD7' 
		| '\uFFDA'..'\uFFDC' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Lm :( '\u02B0'..'\u02B8' 
		| '\u02BB'..'\u02C1' 
		| '\u02D0'..'\u02D1' 
		| '\u02E0'..'\u02E4' 
		| '\u02EE' | '\u037A' | '\u0559' | '\u0640' 
		| '\u06E5'..'\u06E6' 
		| '\u0E46' | '\u0EC6' | '\u17D7' | '\u1843' | '\u3005' 
		| '\u3031'..'\u3035' 
		| '\u303B' 
		| '\u309D'..'\u309E' 
		| '\u30FC'..'\u30FE' 
		| '\uFF70' 
		| '\uFF9E'..'\uFF9F' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Mn :( '\u0300'..'\u034F' 
		| '\u0360'..'\u036F' 
		| '\u0483'..'\u0486' 
		| '\u0591'..'\u05A1' 
		| '\u05A3'..'\u05B9' 
		| '\u05BB'..'\u05BD' 
		| '\u05BF' 
		| '\u05C1'..'\u05C2' 
		| '\u05C4' 
		| '\u064B'..'\u0655' 
		| '\u0670' 
		| '\u06D6'..'\u06DC' 
		| '\u06DF'..'\u06E4' 
		| '\u06E7'..'\u06E8' 
		| '\u06EA'..'\u06ED' 
		| '\u0711' 
		| '\u0730'..'\u074A' 
		| '\u07A6'..'\u07B0' 
		| '\u0901'..'\u0902' 
		| '\u093C' 
		| '\u0941'..'\u0948' 
		| '\u094D' 
		| '\u0951'..'\u0954' 
		| '\u0962'..'\u0963' 
		| '\u0981' | '\u09BC' 
		| '\u09C1'..'\u09C4' 
		| '\u09CD' 
		| '\u09E2'..'\u09E3' 
		| '\u0A02' | '\u0A3C' 
		| '\u0A41'..'\u0A42' 
		| '\u0A47'..'\u0A48' 
		| '\u0A4B'..'\u0A4D' 
		| '\u0A70'..'\u0A71' 
		| '\u0A81'..'\u0A82' 
		| '\u0ABC' 
		| '\u0AC1'..'\u0AC5' 
		| '\u0AC7'..'\u0AC8' 
		| '\u0ACD' | '\u0B01' | '\u0B3C' | '\u0B3F' 
		| '\u0B41'..'\u0B43' 
		| '\u0B4D' | '\u0B56' | '\u0B82' | '\u0BC0' | '\u0BCD' 
		| '\u0C3E'..'\u0C40' 
		| '\u0C46'..'\u0C48' 
		| '\u0C4A'..'\u0C4D' 
		| '\u0C55'..'\u0C56' 
		| '\u0CBF' | '\u0CC6' 
		| '\u0CCC'..'\u0CCD' 
		| '\u0D41'..'\u0D43' 
		| '\u0D4D' | '\u0DCA' 
		| '\u0DD2'..'\u0DD4' 
		| '\u0DD6' | '\u0E31' 
		| '\u0E34'..'\u0E3A' 
		| '\u0E47'..'\u0E4E' 
		| '\u0EB1' 
		| '\u0EB4'..'\u0EB9' 
		| '\u0EBB'..'\u0EBC' 
		| '\u0EC8'..'\u0ECD' 
		| '\u0F18'..'\u0F19' 
		| '\u0F35' | '\u0F37' | '\u0F39' 
		| '\u0F71'..'\u0F7E' 
		| '\u0F80'..'\u0F84' 
		| '\u0F86'..'\u0F87' 
		| '\u0F90'..'\u0F97' 
		| '\u0F99'..'\u0FBC' 
		| '\u0FC6' 
		| '\u102D'..'\u1030' 
		| '\u1032' 
		| '\u1036'..'\u1037' 
		| '\u1039' 
		| '\u1058'..'\u1059' 
		| '\u1712'..'\u1714' 
		| '\u1732'..'\u1734' 
		| '\u1752'..'\u1753' 
		| '\u1772'..'\u1773' 
		| '\u17B7'..'\u17BD' 
		| '\u17C6' 
		| '\u17C9'..'\u17D3' 
		| '\u180B'..'\u180D' 
		| '\u18A9' 
		| '\u20D0'..'\u20DC' 
		| '\u20E1' 
		| '\u20E5'..'\u20EA' 
		| '\u302A'..'\u302F' 
		| '\u3099'..'\u309A' 
		| '\uFB1E' 
		| '\uFE00'..'\uFE0F' 
		| '\uFE20'..'\uFE23' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Mc :( '\u0903' 
		| '\u093E'..'\u0940' 
		| '\u0949'..'\u094C' 
		| '\u0982'..'\u0983' 
		| '\u09BE'..'\u09C0' 
		| '\u09C7'..'\u09C8' 
		| '\u09CB'..'\u09CC' 
		| '\u09D7' 
		| '\u0A3E'..'\u0A40' 
		| '\u0A83' 
		| '\u0ABE'..'\u0AC0' 
		| '\u0AC9' 
		| '\u0ACB'..'\u0ACC' 
		| '\u0B02'..'\u0B03' 
		| '\u0B3E' | '\u0B40' 
		| '\u0B47'..'\u0B48' 
		| '\u0B4B'..'\u0B4C' 
		| '\u0B57' 
		| '\u0BBE'..'\u0BBF' 
		| '\u0BC1'..'\u0BC2' 
		| '\u0BC6'..'\u0BC8' 
		| '\u0BCA'..'\u0BCC' 
		| '\u0BD7' 
		| '\u0C01'..'\u0C03' 
		| '\u0C41'..'\u0C44' 
		| '\u0C82'..'\u0C83' 
		| '\u0CBE' 
		| '\u0CC0'..'\u0CC4' 
		| '\u0CC7'..'\u0CC8' 
		| '\u0CCA'..'\u0CCB' 
		| '\u0CD5'..'\u0CD6' 
		| '\u0D02'..'\u0D03' 
		| '\u0D3E'..'\u0D40' 
		| '\u0D46'..'\u0D48' 
		| '\u0D4A'..'\u0D4C' 
		| '\u0D57' 
		| '\u0D82'..'\u0D83' 
		| '\u0DCF'..'\u0DD1' 
		| '\u0DD8'..'\u0DDF' 
		| '\u0DF2'..'\u0DF3' 
		| '\u0F3E'..'\u0F3F' 
		| '\u0F7F' | '\u102C' | '\u1031' | '\u1038' 
		| '\u1056'..'\u1057' 
		| '\u17B4'..'\u17B6' 
		| '\u17BE'..'\u17C5' 
		| '\u17C7'..'\u17C8' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Nd :( '\u0030'..'\u0039' 
		| '\u0660'..'\u0669' 
		| '\u06F0'..'\u06F9' 
		| '\u0966'..'\u096F' 
		| '\u09E6'..'\u09EF' 
		| '\u0A66'..'\u0A6F' 
		| '\u0AE6'..'\u0AEF' 
		| '\u0B66'..'\u0B6F' 
		| '\u0BE7'..'\u0BEF' 
		| '\u0C66'..'\u0C6F' 
		| '\u0CE6'..'\u0CEF' 
		| '\u0D66'..'\u0D6F' 
		| '\u0E50'..'\u0E59' 
		| '\u0ED0'..'\u0ED9' 
		| '\u0F20'..'\u0F29' 
		| '\u1040'..'\u1049' 
		| '\u1369'..'\u1371' 
		| '\u17E0'..'\u17E9' 
		| '\u1810'..'\u1819' 
		| '\uFF10'..'\uFF19' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Pc :( '\u005F' 
		| '\u203F'..'\u2040' 
		| '\u30FB' 
		| '\uFE33'..'\uFE34' 
		| '\uFE4D'..'\uFE4F' 
		| '\uFF3F' | '\uFF65' 
		)
	;

// inherited from grammar UnicodeLexerBase
protected UNICODE_CLASS_Cf :( '\u06DD' | '\u070F' | '\u180E' 
		| '\u200C'..'\u200F' 
		| '\u202A'..'\u202E' 
		| '\u2060'..'\u2063' 
		| '\u206A'..'\u206F' 
		| '\uFEFF' 
		| '\uFFF9'..'\uFFFB' 
		)
	;


