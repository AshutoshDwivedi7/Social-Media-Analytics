
# coding: utf-8

# In[7]:


import pandas as ps
import numpy as np

zyrtec_data =ps.read_csv("C:/Users/vigne/Documents/Zyrtec_new.csv")

zyrtec_data = zyrtec_data.drop(["status_id","created_at","user_id","screen_name","source","reply_to_status_id","reply_to_user_id","reply_to_screen_name","is_quote","is_retweet","favorite_count","retweet_count","hashtags","symbols","urls_url","urls_t.co","urls_expanded_url","media_url","media_t.co","media_expanded_url","media_type","ext_media_url","ext_media_t.co","ext_media_expanded_url","ext_media_type","mentions_user_id","mentions_screen_name","lang","quoted_status_id","quoted_text","retweet_status_id","retweet_text","place_url","place_name","place_full_name","place_type","country","country_code","geo_coords","coords_coords","bbox_coords"],1)
print(zyrtec_data)



# In[8]:


import re
regexp_url = 'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+'
pattern_url = re.compile(regexp_url, re.UNICODE | re.IGNORECASE)
zyrtec_data['text']=zyrtec_data['text'].replace(pattern_url, " ", regex=True)


regexp_mention = '(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z0-9_]+[A-Za-z0-9_]+)'
pattern_mention = re.compile(regexp_mention, re.UNICODE | re.IGNORECASE)
zyrtec_data['text']=zyrtec_data['text'].replace(pattern_mention, " ", regex=True)


zyrtec_data['text']=zyrtec_data['text'].replace('#', "hashtag_ ", regex=True)

zyrtec_data


# In[18]:


zyrtec_data.to_csv('Zyrtec_cleaned.csv')


# In[9]:


count_vector = CountVectorizer(binary = False, stop_words='english' ) #Count Vectorization
Zyrtec_X = count_vector.fit_transform(zyrtec_data["text"])
Zyrtec_X


# In[11]:


Allegra_data =ps.read_csv("C:/Users/vigne/Documents/Allegra_new.csv")

Allegra_data = Allegra_data.drop(["status_id","created_at","user_id","screen_name","source","reply_to_status_id","reply_to_user_id","reply_to_screen_name","is_quote","is_retweet","favorite_count","retweet_count","hashtags","symbols","urls_url","urls_t.co","urls_expanded_url","media_url","media_t.co","media_expanded_url","media_type","ext_media_url","ext_media_t.co","ext_media_expanded_url","ext_media_type","mentions_user_id","mentions_screen_name","lang","quoted_status_id","quoted_text","retweet_status_id","retweet_text","place_url","place_name","place_full_name","place_type","country","country_code","geo_coords","coords_coords","bbox_coords"],1)
print(Allegra_data)


# In[12]:


Allegra_data['text']=Allegra_data['text'].replace(pattern_url, " ", regex=True)


regexp_mention = '(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z0-9_]+[A-Za-z0-9_]+)'
pattern_mention = re.compile(regexp_mention, re.UNICODE | re.IGNORECASE)
Allegra_data['text']=Allegra_data['text'].replace(pattern_mention, " ", regex=True)


Allegra_data['text']=Allegra_data['text'].replace('#', "hashtag_ ", regex=True)

Allegra_data


# In[19]:


Allegra_data.to_csv('Allegra_cleaned.csv')


# In[13]:


count_vector = CountVectorizer(binary = False, stop_words='english' ) #Count Vectorization
Allegra_X = count_vector.fit_transform(Allegra_data["text"])
Allegra_X


# In[15]:


Claritin_data =ps.read_csv("C:/Users/vigne/Documents/Claritin_new.csv")

Claritin_data = Claritin_data.drop(["status_id","created_at","user_id","screen_name","source","reply_to_status_id","reply_to_user_id","reply_to_screen_name","is_quote","is_retweet","favorite_count","retweet_count","hashtags","symbols","urls_url","urls_t.co","urls_expanded_url","media_url","media_t.co","media_expanded_url","media_type","ext_media_url","ext_media_t.co","ext_media_expanded_url","ext_media_type","mentions_user_id","mentions_screen_name","lang","quoted_status_id","quoted_text","retweet_status_id","retweet_text","place_url","place_name","place_full_name","place_type","country","country_code","geo_coords","coords_coords","bbox_coords"],1)
print(Claritin_data)


# In[16]:


Claritin_data['text']=Claritin_data['text'].replace(pattern_url, " ", regex=True)


regexp_mention = '(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z0-9_]+[A-Za-z0-9_]+)'
pattern_mention = re.compile(regexp_mention, re.UNICODE | re.IGNORECASE)
Claritin_data['text']=Claritin_data['text'].replace(pattern_mention, " ", regex=True)


Claritin_data['text']=Claritin_data['text'].replace('#', "hashtag_ ", regex=True)

Claritin_data


# In[20]:


Claritin_data.to_csv('Claritin_cleaned.csv')


# In[17]:


count_vector = CountVectorizer(binary = False, stop_words='english' ) #Count Vectorization
Claritin_X = count_vector.fit_transform(Claritin_data["text"])
Claritin_X


# In[8]:


import pandas as ps
import numpy as np
import re
Analysis =ps.read_csv("C:/Users/vigne/Documents/Analysis.csv")

Analysis = Analysis.drop(["Sno","status_id","created_at","user_id","screen_name","source","reply_to_status_id","reply_to_user_id","reply_to_screen_name","is_quote","is_retweet","favorite_count","retweet_count","hashtags","symbols","urls_url","urls_t.co","urls_expanded_url","media_url","media_t.co","media_expanded_url","media_type","ext_media_url","ext_media_t.co","ext_media_expanded_url","ext_media_type","mentions_user_id","mentions_screen_name","lang","quoted_status_id","quoted_text","retweet_status_id","retweet_text","place_url","place_name","place_full_name","place_type","country","country_code","geo_coords","coords_coords","bbox_coords"],1)

print(Analysis)

regexp_url = 'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+'
pattern_url = re.compile(regexp_url, re.UNICODE | re.IGNORECASE)

Analysis['text']=Analysis['text'].replace(pattern_url, " ", regex=True)

regexp_mention = '(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z0-9_]+[A-Za-z0-9_]+)'
pattern_mention = re.compile(regexp_mention, re.UNICODE | re.IGNORECASE)
Analysis['text']=Analysis['text'].replace(pattern_mention, " ", regex=True)


Analysis['text']=Analysis['text'].replace('#', "hashtag_ ", regex=True)

Analysis

Analysis.to_csv('Analysis_cleaned.csv')


# In[3]:


from afinn import Afinn
afinn = Afinn()
afinn.score(Analysis.text[1600])
len(Analysis.text)


# In[4]:


from afinn import Afinn
afinn = Afinn()

mylist = []
for x in range(0,len(Analysis.text)):
    mylist.append(afinn.score(Analysis.text[x]))
print (mylist)


# In[11]:


se = ps.Series(mylist)
len(se)
Analysis['Sentiment_Score'] = se.values
print(Analysis)

Analysis.to_csv('Analysis_with_Sentiment_Score.csv')


# In[6]:


print (Analysis.text[2])
afinn.score(Analysis.text[2])


# In[12]:


Analysis_filetered = Analysis[Analysis['Sentiment_Score'] <0]
Analysis_filetered
Analysis_filetered.to_csv('Analysis_with_Negative_Sentiment_Score.csv')

