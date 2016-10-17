#*StaDyn*

Dynamic languages are becoming increasingly popular for developing different kinds of applications such as adaptable and adaptive software, Web development, application frameworks, game engines, interactive programming, rapid prototyping, and dynamic aspect-oriented programming. These languages build on the Smalltalk idea of supporting reasoning about (and customizing) program structure, behavior and environment at runtime.

Dynamic languages do not perform type checking at compile time like statically typed languages (Java, C# or C++), because runtime adaptability is implemented with dynamic type systems. This postponement causes three major drawbacks:

1. **Performance**. The exact knowledge of object structure at compile time makes possible the generation of optimum code. This information need not to be retrieved at runtime, causing a performance penalty.
2. **No early detection of type errors**. Dynamic type checking do not make possible to fix programming errors immediately rather than discovering them at runtime; when the programmer's efforts might be aimed at some other task, or even after the program has been deployed.
3. **Legibility loss**. Type declarations constitute a form of documentation, giving useful hints about behavior and structure. Unlike descriptions embedded in comments, this form of documentation cannot become outdated, since it is checked during every run of the compiler.

##Project Aim
The main objective of this project is combining the benefits of both dynamic and static languages in just one single programming language: *StaDyn*. *StaDyn* permits straightforward development of adaptable software and rapid prototyping, without sacrificing application robustness, performance and legibility of source code.

Static typing is centered on making sure that programs behave correctly at runtime. This is the reason why languages with static typing employ a pessimistic policy regarding to programs correctness. This pessimism causes compilation errors of programs that are dynamically correct. The following Java code shows this limitation:

```C#
        Object[] v=new Object[10]; 
        for (int i = 0; i < 10; i++) { 
            v[i] = "String " + i; 
            int length = v[i].length();  // Compilation error
        } 
```

Dynamic languages follow the opposite point of view. They do not perform type checking at compile time at all. Dynamic languages are very optimistic, compiling programs that might be identified as erroneous statically. The following code is a Python example:

```
        myObjet = object()
        length = myObjet.length()  # No compilation error
```                 
                    
##Language Benefits

1. *Improving the Performance, Robustness, Legibility and Scalability of dynamic languages*. Adding a flexible static type system to a dynamic language will produce the previous benefits. As an example, the previous Python code will show a compile-time error.
2. *Improving the adaptability and rapid prototyping features of "static" languages*. Using type inference and type reconstruction techniques, together with constraint based type systems, will make typeable a higher number of programs that are dynamically correct. These features imply a static duck typing system. It is not necessary to use the explicitly Java interface based programming style. Objects interface is inferred statically.
3. *Separation of the Dynamism Concern*. To make dynamic and static type systems converge, we follow the Separation of Concerns principle applied to our programming language. The programmer may specify those parts of the code that need a higher adaptability (dynamic) and those that that may guarantee a correct behavior at runtime (static). This separation permits to turn rapidly developed prototypes into a final robust and efficient application. It will also be possible to make parts of an application flexible, maintaining the robustness of the rest of the program.
4. *Direct Interoperation between Static and Dynamic Languages*. This is a side effect of the previous benefit, caused by sharing the same type system and platform in both sort of language. A set of rules to convert optimistic code into pessimistic are set to make static and dynamic code really interoperable.
5. *High Level of Legibility and Simplicity*. The absence of obligatory type reference specification implies a loss of legibility in source code. A constraint-based type system will be able to document restrictions using an attribute (annotation) based notation. It is worth noting that these annotations are automatically generated by the environment; not by the programmer. This way, the benefits obtained are twofold: first, the legibility offered by types is not missed; second, other languages would interoperate with *StaDyn*.
Opposite to our approach Java uses bounded polymorphism. In standard Java 1.6, the ```min``` method of the ```java.util.Collections``` class (returns the min value in a collection) is declared this way:

```Java
        public static  <T extends Object & Comparable<? super T>> T min(Collection<? extends T> coll)	
```

In our language, we simply write:

```
        public static var min(var coll)	
```

The type system infers the restrictions that the parameter must satisfy, analyzing its source code. These restrictions are automatically annotated by the compiler.

For more detailed information, please visit the [*StaDyn* website](http://www.reflection.uniovi.es/stadyn/).
