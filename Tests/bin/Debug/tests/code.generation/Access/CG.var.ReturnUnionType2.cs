using System;

class VarReturnUnionType
{
   public static var union1(bool condicion)
   {
      var ret;

      if (condicion)
         ret =  2;
      else
         ret = 1.5;

      return ret;
   }
   public static var union2(bool condicion)
   {
      var ret;

      if (condicion)
         ret = "2";
      else
         ret = 1.5;

      return ret;
   }

   static void Main()
   {
      var a = VarReturnUnionType.union1(true);
      if (a != 2)
         Environment.Exit(-1);

      var b = VarReturnUnionType.union1(false);
      if (b != 1.5)
         Environment.Exit(-1);

      var c = VarReturnUnionType.union2(true);
      if (!(c.Equals("2")))
         Environment.Exit(-1);

      var d = VarReturnUnionType.union2(false);
      if (d != 1.5)
         Environment.Exit(-1);

   }
}