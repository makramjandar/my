### `MSSQL`  
# [One-Shot Upswing ♫ ♪](https://medium.com/@makramjandar/sql-server-one-shot-upswing-148496935cb4)  

<img align="left" width="70" height="70" src="https://i.gyazo.com/5c4540d073c48de2e9dbbbd85f1e9cc7.gif">  

*For convenience, babble parsimony and scripts pumping...*  
*Please refer to the links.*  
*© under Do WTF You Want !!*
# []()

<p align="center">
<img align="center" width="400" height="250" src="https://cdn-images-1.medium.com/max/800/1*9gen4BbBrZTW-ehrrOZ11Q.png">
</p>

__`Reverse-Engineering` or `Normalization|Denormalization` `BI Flattening`  `Conditional Memory-Optimized table creation` `Bulk Insert` `Exploratory Pivoting` `SQL Performance Tuning`__

The main purpose of this tutorial is to introduce some `SQL Techies` wich exhibits a very simplified version of SQL performance hacking and `automation scripting`!!  
So hopefully, it’s hand-on approach will be useful for you as well… Evidently, here and there, you’ll find enough articles, chunks and hunks that deal in-depth with the ensuing practices.

# []()

<img align="left" width="400" height="250" src="https://cdn-images-1.medium.com/max/800/1*242FubZV1QpxMVG5Y0p4Jw.png">
<dl>
  <p><b>The issues ?!! </b></p>
  <p>Based on the <a href="https://gist.github.com/makramjandar/6bbd4c7eb82e39c0a51c2484ec626f49#file-oneshotupswing-gradeslist-csv"><b>List</b></a> of students grades we simply have to,</p>
  <dd><b>1. </b>Replace the negatives entries with their absolutes values.</dd>
  <dd><b>2. </b>Calculate the average score with a coefficient of 1/6 for the tests subtotals and 1/3 for the final score.</dd>
  <dd><b>3. </b>Another typing error is at the origin of the one rank shift of the 4<sup>th</sup> test… we must also correct the boo-boo without (very challenging indeed !!) using the <b>Lead()</b> function !!</dd>
</dl>

# []()

<dl>
  <p><b>L</b>et it be, first, we'll use the following script to define and populate our original grades table:</p>
  <dd><a href="https://gist.github.com/makramjandar/0f3ebf828b67ba5e182d8dcbfa8d9911#file-oneshotupswing-bulkinsert-sql"><b>$ table definition</b> + <b>bulk insert</b></a></dd>
</dl>

# []()

<img align="right" width="400" height="280" src="https://cdn-images-1.medium.com/max/800/1*EnENdgJg80Dl_lllMZLIyA.png">
<dl>
  <p><b>T</b>hen, prior to analysis, let's apply the 2 steps normalization:</p>
  <dd><a href="https://gist.github.com/makramjandar/cb95c3d8e258576ca7783c4e4c71629a#file-oneshotupswing-tablescreation-sql"><b>$ In-Memory OLTP</b></a>: MSSQL conditional version-based (Memory-Optimized | Traditional on-disk)</dd>
  <dd><a href="https://gist.github.com/makramjandar/4a1c56f26472bccea9f1efefe759d829#file-oneshotupswing-normalization-sql"><b>$ Normalization</b></a>: Settle cleaned data and populating the newly created table.</dd>
</dl>
  <p><em>We can apply those techies to recreate the relational tables, indexes, or even to automate data migration and all the sub-processes of the MERISE model-based just on the fly. Conceptually, the required bricks are exposed right here, up to you to extrapolate, fine-tune, tweak and so on ?!!</em></p>

# []()

<dl>
  <p><b>S</b>o, as our rocky data are now <em>nooormalized</em>, sleekly indexed and fields just in a well-shaped suit, we can then start slice & dice like Daddy in Mommy <b>☻ ☺</b>!! <em>you’ll groove on, indeed, my so Benetton politically correct emoticons…</em></p>
  <dd><a href="https://gist.github.com/makramjandar/175ee9bc6fa632edf869b395307e5f58#file-oneshotupswing-exploratorypivoting-sql"><b>$ Exploratory Pivoting</b></a>: The average score of each student.</dd>
</dl>

# []()

<img align="left" width="400" height="280" src="https://cdn-images-1.medium.com/max/800/1*xXjr9rN80o4BV5otPYDbMQ.gif">
<dl>
  <p><b>Performance Tuning: </b>Now, let’s try simulating the <b>LEAD()</b> one, just in case ?! <em>Yeah, I’m fiercely devoted to the Shadoks motto: Why make it simple when you can make it complicated ?!!</em></p>
  <dd><a href="https://gist.github.com/makramjandar/8936fc8b39cae35544f89e70b53ff9f8#file-oneshotupswing-analyticalfunction-sql"><b>$ with Analytical function</b></a>,</dd>
  <dd><a href="https://gist.github.com/makramjandar/ca87c3dc4e6b94d21e3e5b48b9c705ad#file-oneshotupswing-nojoins-sql"><b>$ with No Joins</b></a>,</dd>
  <dd><a href="https://gist.github.com/makramjandar/18359a2d9a68dd6179bdd5afc0cbd43c#file-oneshotupswing-cteusage-sql"><b>$ CTE usage</b></a>,</dd>
  <dd><a href="https://gist.github.com/makramjandar/ee9949b919e349ba240da3ed88ff7048#file-oneshotupswing-cteusagewithjoins-sql"><b>$ another CTE usage with Joins</b></a>,</dd>
  <dd>and the 🏆 is the <a href="https://gist.github.com/makramjandar/24d3eea44f6857336e78229c4580c525#file-oneshotupswing-corelatedsubquery-sql"><b>$ co-Related Subquery</b></a>.</dd>

# []()

<img align="right" width="70" height="70" src="https://i.gyazo.com/5c4540d073c48de2e9dbbbd85f1e9cc7.gif">  
 
⚠  
<b><em>Prerequisites:</em></b>  
__$__ *Save the __[gradesList.csv](https://gist.github.com/makramjandar/6bbd4c7eb82e39c0a51c2484ec626f49)__
file in drive `C:`.*
# []()

*and for the so-beloved lazy ones,*  
*the one-shot processing*  
*__[scriptReady](https://gist.github.com/makramjandar/81e737251b35fdecdc2d7b8e67567508)__* ❤️  
*GO !!*
