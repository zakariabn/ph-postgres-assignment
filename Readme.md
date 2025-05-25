# Q&A

> **What is PostgreSQL?**

**PostgreSQL** হলো একটা জনপ্রিয় Relational Database management system(RDBMS)। যেটা সুম্পুর্ন ফ্রি বা (open source)। এইটা SQL নমক ভাষা ব্যাবহার করে ।

<br>

> **What is the purpose of a database schema in PostgreSQL?**

Schema একটি গাইডলাইন যা অনুসরণ করা বাধ্যতামূলক। কারণ মানুষ মাত্রই ভুল করে, আর যদি সেটা বিশাল codebase বা বড় কোনো কোম্পানির ডাটাবেস হয়, যেখানে অনেক ডেভেলপার একসাথে কাজ করবে এবং বিভিন্ন জন বিভিন্ন অংশে কাজ করবে, তখন সেখানে অনেক সমস্যা আসতে পারে। যেমন: type safety, delete rule, update rule ইত্যাদি। এই কারণেই schema খুবই গুরুত্বপূর্ণ।

<br>

> **Explain the `Primary` Key and `Foreign Key` concepts in PostgreSQL.**

প্রথমত KEY হল একটি কলাম বা কলামের সেট যা প্রতিটি রেকর্ডের জন্য একটি Unicq চিহ্ন বা আইডেন্টিফায়ার হিসেবে কাজ করে। এটি ডেটাবেস টেবিলে প্রতিটি রেকর্ডকে অনন্যভাবে চিহ্নিত করে।

- **Primary key** এর মাধ্যমে নিজ টেবিলের প্রতিটা record/row কে unicq ভাবে চিহ্নত করা যায়।
- **Foreign Key** হোল অন্য টেবিলের `Primary key` যাকে বসানো হয় এই টেবিলে, যাতে ঐ টেবিলের সাথে একটা সম্পর্ক তৈরি করা যায়।

<br>

> **What is the difference between the `VARCHAR` and `CHAR` data types?**

এই দুইটাই string type এর data store করার জন্য ব্যাবহার হয়ে থাকে । VARCHAR এবং CHAR ডেটা টাইপের মধ্যে মূল পার্থক্য হল স্ট্রিংয়ের দৈর্ঘ্য এবং কিভাবে স্টোরেজ Management করে ।

- ARCHAR এটি শুধুমাত্র প্রয়োজনীয় স্টোরেজ ব্যবহার করে, অর্থাৎ স্ট্রিংয়ের আসল দৈর্ঘ্য অনুযায়ি স্টোরেজ নিয়ে থাকে যদিও আপনি বেশি storage alocate koren ।
  যেমন `VARCHAR(10)` এইখানে alocate করা হছে ১০ byte, কিন্ত আপনি input দিলেন ('rahim') তাইলে এইখানে storage নিবে 5 byte ।

- CHAR একই ধরনের কাজ করে কিন্তু পার্থক্য সে storage নিবে ১০ byte ।

<br>

> **Explain the purpose of the `WHERE` clause in a `SELECT` statement.**

SELECT এর মাধমে ডেটাবেস থেকে data retrieve করা হয়. যখন এইটা করা হয় তখন একটা ডেটাবেস এর সব ডেটা চলে আসে যা সম্পুর্ন Unnesesary. কারন আমাদের অধিকাংশ ক্ষেত্রেই সব ডেটার দরকার হয় না । এইখানেই WHEAE clause এর purpose বুঝা যায়। এটি নির্দিষ্ট শর্ত বা কন্ডিশন অনুযায়ী আমাদের ডেটা এনে দেয় ।
