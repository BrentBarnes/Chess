
<h1><span style="text-decoration: underline;"><strong>Chess</strong></span></h1>
<p>This has been a long and challenging project. It took me two and a half months to complete, but I am so proud to have finished. The journey was full of ups and downs, and it often felt like taking two steps back to take three steps forward.</p>
<p>While I can say that this program was built from scratch, I would also like to recognize that I could not have done it without <strong>The Odin Project</strong> community <strong>Discord</strong> server. <strong>Josh</strong>, <strong>Roli</strong>, <strong>Crespire</strong>, and many others voluntarily messaged with me back and forth for hours at a time. Their help genuinely made all the difference, and for that I am endlessly grateful!</p>
<p>&nbsp;</p>
<h2><span style="text-decoration: underline;"><strong>Features of Chess</strong></span></h2>
<ul>
<li>Game Modes
<ul>
<li>Human vs. Human</li>
<li>Human vs. Computer</li>
<li>Computer vs. Computer</li>
</ul>
</li>
<li>Colorized Chess Board</li>
<li>Players move pieces using coordinates like 'a1' or 'e5'</li>
<li>Red dots indicate legal moves</li>
<li>Enemy pieces that can be captured have a red background</li>
<li>When an enemy piece is captured, it gets added to your graveyard</li>
<li>Illegal moves tell you why they're illegal</li>
<li>Once a piece is selected, it can be unselected</li>
<li>The game can be saved to JSON at the beginning of a player's turn</li>
<li>Upon starting the game, the old, saved game can be loaded</li>
<li>Full check and Checkmate detection</li>
<li>Asks for rematch and will replay from the beginning</li>
</ul>
<h2><span style="text-decoration: underline;"><strong>Other Features of the Code</strong></span></h2>
<ul>
<li>The Piece class makes use of the Template Method Design Pattern</li>
<li>The Cell class makes use of the Null Object Design Pattern</li>
<li>Factories are used for piece creation</li>
<li>Slight polymorphism is used for the different game modes</li>
</ul>
<h2><span style="text-decoration: underline;"><strong>Things to Add</strong></span></h2>
<ul>
<li>Castling</li>
<li>En Passant</li>
<li>Pawn promotion</li>
<li>Other fancy game moves</li>
</ul>
<p>&nbsp;</p>
<h1><span style="text-decoration: underline;"><strong>The Biggest Challenge</strong></span></h1>
<p>By far, the biggest challenge was wrapping my mind around <strong>Object Oriented Design priciples</strong>. At first, I tried to write my Ruby code the same way I had written my procedural Javascript code. I thought I was close to the end of the project when I was able to move pieces, but I got stuck because my classes were so jumbled up.</p>
<p>When I went to the TOP Discord multiple great folks said that my program was <strong>begging</strong> for more classes and my classes were <strong>begging</strong> to be smarter. I think I had <strong>five classes</strong> handling <span style="text-decoration: underline;"><strong>EVERYTHING</strong></span>. That's when someone mentioned that they had <strong>over thirty classes</strong> in their solution to Chess. Obviously I was doing something inefficiently.</p>
<p>This is when I had to swallow my urge to plow forward. I had read about half of <span style="text-decoration: underline;"><em>Practical Object Oriented Design Principles</em></span> by <strong>Sandi Metz</strong> months before getting stuck, and I thought I knew OOP because I understood how <strong>messages</strong> worked between classes. Then someone told me <em><span style="text-decoration: underline;">99 Bottles of OOP</span></em> by <strong>Sandi Metz</strong> might help. <strong>And It did!</strong></p>
<p>99 Bottles made me realize that <strong>polymorphism was perhaps the most magical aspect of OOP.</strong> I also realized that I knew <strong>NOTHING</strong> about it! So, I read and worked alongside the book for a week or two, then got back to work. It took a few chats on Discord to understand how to apply this new knowledge to my Chess project. However, once the ball was rolling, <strong>I took off</strong>.</p>
<p>I was able to apply the <strong>Template method</strong> to my Piece class hierarchy, and it felt great! I was also able to use <strong>design paterns and polymorphism</strong> in some other places. I must admit that I do not consider myself a master of design patterns and polymorphism. However, what this taught me was that <strong>there really is magic to OOP.</strong></p>
<p>Moving forward in my OOP education, I have another book called <span style="text-decoration: underline;"><em>Head First Design Patterns</em></span> by <strong>Eric Freeman</strong> &amp; <strong>Elisabeth Robson</strong> that goes over these inspiring design patterns in much more depth and detail.</p>
<h2><span style="text-decoration: underline;"><strong>In Conclusion</strong></span></h2>
<p>This was a humbling and massively beneficial project that I don't know if I'll <strong>ever</strong> forget. This was a tough project to cut my teeth on, but I look forward to returning to this game when I have far more experience.<br /></p>
