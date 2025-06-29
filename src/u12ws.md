<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
        <h1>Unit 12 Worksheet - Baselines & Benchmarks</h1>
    </p>
</div>

## Instructions

---

Fill out the worksheet as you progress through the lab and discussions.
Hold your worksheets until the end to turn them in as a final submission packet.

### Resources / Important Links

- [Kaggle - Python and Data Science Learning](https://www.kaggle.com/learn)

#### Downloads

The worksheet has been provided below. The document(s) can be transposed to
the desired format so long as the content is preserved. For example, the `.txt`
could be transposed to a `.md` file.

- <a href="./assets/downloads/u12/u12_worksheet.txt" target="_blank" download>📥 u12_worksheet(`.txt`)</a>
- <a href="./assets/downloads/u12/u12_worksheet.docx" target="_blank" download>📥 u12_worksheet(`.docx`)</a>

### Unit 12 Recording

<iframe
    style="width: 100%; height: 100%; border: none;
    aspect-ratio: 16/9; border-radius: 1rem; background:black"
    src="https://www.youtube.com/embed/8psu0D4rSmc?si=8QOnuGhcCA_0Fp7S"
    title="Unit 12 - Baselining and Benchmarking Systems"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen>
</iframe>

#### Discussion Post #1

Scenario:

<blockquote>

Your manager has come to you with another emergency.

He has a meeting next week to discuss capacity planning and usage of the system with IT upper management.
He doesn’t want to lose his budget, but he has to prove that the system utilization warrants spending more.

</blockquote>

1. What information can you show your manager from your systems?

2. What type of data would prove system utilization? (Remember the big 4: compute,
   memory, disk, networking)

3. What would your report look like to your manager?

#### Discussion Post #2

Scenario:

<blockquote>

You are in a capacity planning meeting with a few of the architects.
They have decided to add 2 more agents to your Linux systems, a Bacula Agent and an Avamar Agent.
They expect these agents to run their work starting at 0400 every morning.

</blockquote>

![7 day view](https://github.com/user-attachments/assets/d3a4bdaf-43ad-4317-b7b3-232395765b25)
![24 hour view](https://github.com/user-attachments/assets/a3b0fbcb-6ac6-402c-8e3f-4c0a39ca858b)

1. What do these agents do? (May have to look them up)

2. Do you think there is a good reason not to use these agents at this timeframe?

3. Is there anything else you might want to point out to these architects about these agents they are installing?

#### Discussion Post #3

Scenario:

<blockquote>

Your team has recently tested at proof of concept of a new storage system. 
The vendor has published the blazing fast speeds that are capable of being
run through this storage system. You have a set of systems connected to both the old
storage system and the new storage system.

</blockquote>

1. Write up a test procedure of how you may test these two systems.

2. How are you assuring these test are objective?
   - What is meant by the term Ceteris Paribus, in this context?

<div class="warning">
Submit your input by following the link below.

The discussion posts are done in Discord threads. Click the 'Threads' icon on the top right and search for the discussion post.

</div>

- [Link to Discussion Posts](https://discord.com/channels/611027490848374811/1365776270800977962)

## Definitions

---

Baseline:

Benchmark:

High watermark:

Scope:

Methodology:

Testing:

Control:

Experiment:

Analytics:

## Digging Deeper (optional)

---

1. Analyzing data may open up a new field of interest to you. Go through some of the  
   free lessons on Kaggle, here: https://www.kaggle.com/learn

   - What did you learn?
   - How will you apply these lessons to data and monitoring you have already  
     collected as a system administrator?

2. Find a blog or article that discusses the 4 types of data analytics.

   - What did you learn about past operations?
   - What did you learn about predictive operations?

3. Download Spyder IDE (Open source).
   - Find a blog post or otherwise try to evaluate some data.
   - Perform some Linear regression. My block of code (but this requires some  
     additional libraries to be added. I can help with that if you need it.)
     ```python
     import matplotlib.pyplot as plt
     from sklearn.linear_model import LinearRegression
     size = [[5.0], [5.5], [5.9], [6.3], [6.9], [7.5]]
     price =[[165], [200], [223], [250], [278], [315]]
     plt.title('Pizza Price plotted against the size')
     plt.xlabel('Pizza Size in inches')
     plt.ylabel('Pizza Price in cents')
     plt.plot(size, price, 'k.')
     plt.axis([5.0, 9.0, 99, 355])
     plt.grid(True)
     model = LinearRegression()
     model.fit(X = size, y = price)
     #plot the regression line
     plt.plot(size, model.predict(size), color='r')
     ```

## Reflection Questions

---

1. What questions do you still have about this week?

2. How can you apply this now in your current role in IT?  
   If you’re not in IT, how can you look to put something like this into your resume or
   portfolio?
