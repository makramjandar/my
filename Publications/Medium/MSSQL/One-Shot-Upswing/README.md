### `MSSQL`  
# [One-Shot Upswing ♫ ♪](https://medium.com/@makramjandar/sql-server-one-shot-upswing-148496935cb4)  

<img align="left" width="70" height="70" src="https://i.gyazo.com/5c4540d073c48de2e9dbbbd85f1e9cc7.gif">  

*For convenience, babble parsimony and scripts pumping...*  
*Please refer to the links.*  
*© Licensed under Do WTF You Want !!*
#

<img align="right" width="400" height="250" src="https://cdn-images-1.medium.com/max/800/1*9gen4BbBrZTW-ehrrOZ11Q.png">

__`Reverse-Engineering` or `Normalization|Denormalization` `BI Flattening`  `Conditional Memory-Optimized table creation` `Bulk Insert` `Exploratory Pivoting` `SQL Performance Tuning`__

The main purpose of this tutorial is to introduce in a very simplified way some `SQL Techies` concerning `Performance Hacking` and `Automation Scripting` !!
Evidently, here and there, you’ll find enough articles, chunks and hunks that deal in-depth with the ensuing practices.

## The issues ?!! 

<img align="left" width="400" height="280" src="https://cdn-images-1.medium.com/max/800/1*242FubZV1QpxMVG5Y0p4Jw.png">
<dl>
  <p>Based on the <a href="https://gist.github.com/makramjandar/6bbd4c7eb82e39c0a51c2484ec626f49#file-oneshotupswing-gradeslist-csv"><b>List</b></a> of students grades we simply have to,</p>
  <dd><b>1. </b>Replace the negatives entries with their absolutes values.</dd>
  <dd><b>2. </b>Calculate the average score with a coefficient of 1/6 for the tests subtotals and 1/3 for the final score.</dd>
  <dd><b>3. </b>Another typing error is at the origin of the one rank shift of the 4<sup>th</sup> test… we must also correct the boo-boo without (very challenging indeed !!) using the <b>Lead()</b> function !!</dd>
  <p>So let it be, our original grades table is defind and populated with the following script: <a href="https://gist.github.com/makramjandar/0f3ebf828b67ba5e182d8dcbfa8d9911#file-oneshotupswing-bulkinsert-sql"><b>$ table definition + bulk insert</b></a></p>
</dl>

## In-Memory OLTP

<dl>
  <p>First, prior to analysis, let's create our memory optimized staging table:</p>
  <dd><a href="https://gist.github.com/makramjandar/cb95c3d8e258576ca7783c4e4c71629a#file-oneshotupswing-tablescreation-sql"><b>$ MSSQL conditional version-based (Memory-Optimized | Traditional on-disk)</b></a></dd>
</dl>

## Normalization

<img align="right" width="400" height="280" src="https://cdn-images-1.medium.com/max/800/1*EnENdgJg80Dl_lllMZLIyA.png">
<dl>
  <dd><a href="https://gist.github.com/makramjandar/4a1c56f26472bccea9f1efefe759d829#file-oneshotupswing-normalization-sql"><b>$ Next, let's settle cleaned data and populate the newly created table.</b></a></dd>
</dl>
  <p><em>We can apply those techies to recreate the relations, staging tables, indexes, or even to automate data migration and all the sub-processes of the MERISE model-based just on the fly.</em></p>
  <p><em>Conceptually, the required bricks are exposed right here, up to you to extrapolate, fine-tune, tweak and so on ?!!</em></p>

## Exploratory Pivoting

<dl>
  <p>As our rocky data are now <em>nooormalized</em>, sleekly indexed and fields just in a well-shaped suit !! We can start slice & dice like Dad in Mom <b>☻ ☺</b>!! <em>you’ll groove on, indeed, my so inclusive emoticons…</em></p>
  <dd><a href="https://gist.github.com/makramjandar/175ee9bc6fa632edf869b395307e5f58#file-oneshotupswing-exploratorypivoting-sql"><b>$ Then, the average score of each student.</b></a></dd>
</dl>

## Performance Tuning

<img align="left" width="400" height="280" src="https://cdn-images-1.medium.com/max/800/1*xXjr9rN80o4BV5otPYDbMQ.gif">
<dl>
  <p>And finally, let’s try simulating the <b>LEAD()</b> function, just in case ?! <em>Yeah, I’m fiercely devoted to the Shadoks motto: Why make it simple when you can make it complicated ?!!</em></p>
  <dd><a href="https://gist.github.com/makramjandar/8936fc8b39cae35544f89e70b53ff9f8#file-oneshotupswing-analyticalfunction-sql"><b>$ with Analytical function</b></a>,</dd>
  <dd><a href="https://gist.github.com/makramjandar/ca87c3dc4e6b94d21e3e5b48b9c705ad#file-oneshotupswing-nojoins-sql"><b>$ with No Joins</b></a>,</dd>
  <dd><a href="https://gist.github.com/makramjandar/18359a2d9a68dd6179bdd5afc0cbd43c#file-oneshotupswing-cteusage-sql"><b>$ CTE usage</b></a>,</dd>
  <dd><a href="https://gist.github.com/makramjandar/ee9949b919e349ba240da3ed88ff7048#file-oneshotupswing-cteusagewithjoins-sql"><b>$ another CTE usage with Joins</b></a>,</dd>
  <dd>and the <img width="25" height="25" src="https://i.gyazo.com/0afc26f451460a28d7ef9855b5e75bfe.gif"> is the <a href="https://gist.github.com/makramjandar/24d3eea44f6857336e78229c4580c525#file-oneshotupswing-corelatedsubquery-sql"><b>$ co-Related Subquery</b></a>.</dd>

## Prerequisites
   
<img align="left" width="80" height="60" src="https://i.gyazo.com/4082eedd4a3193c565cf98547702e758.gif"><b><em> </em></b>  
__$__ *Save the __[gradesList.csv](https://gist.githubusercontent.com/makramjandar/6bbd4c7eb82e39c0a51c2484ec626f49/raw/5f0ac7dd214f470a6180b6c066bc951b76463fb6/oneShotUpswing-gradesList.csv)__
file in drive `C:`.*
#

*Last but not least, for the so-beloved lazy ones,*  
*the one-shot processing*  
*__[scriptReady](https://gist.github.com/makramjandar/81e737251b35fdecdc2d7b8e67567508)__ <img width="25" height="25" src="https://i.gyazo.com/e1bb682e8dbd6b7220099326f93ab880.gif">*  
*GO !!*
