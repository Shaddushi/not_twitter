<script setup>
    import {ref,computed, onMounted} from 'vue'
    import { useRoute } from 'vue-router';
    import axios from 'axios';
    import HeaderProfile from './HeaderProfile.vue';
    import TweetList from './../TweetComponents/TweetList.vue';
    const route = useRoute()
    const currentProfileName = computed(() => route.params.profileName)
    const username = ref()
    const pseudo = ref()
    const description = ref()
    const user_tweets = ref()
    const tweet_available = ref(false)
    const incorrect_account = ref(false)

    ////////////////////////////////////////////////////////////////////////////////////////////


    onMounted(() =>{
        GetUser()
    })

    //////////////////////////////////////////////////////////////////////////////////////////////

    function GetUser(){
        let data = JSON.stringify(currentProfileName.value)
        axios.post('http://localhost:8080/api/GetUser',data).then((response) => {
            if(response.data.valid){
              username.value = response.data.username
              pseudo.value = response.data.pseudo
              description.value = response.data.description
              GetUserTweet()
            }
            else{
              incorrect_account.value = true
            }
            }).catch((error)=>{
              console.log(error)
            })
    }

    function GetUserTweet(){
        let data = JSON.stringify(username.value)
        axios.post('http://localhost:8080/api/GetTweetUser',data).then((response) => {
            if(response.data.valid){
              user_tweets.value = response.data.tweets 
              tweet_available.value = true
            }
            }).catch((error)=>{
              console.log(error)
            })
    }




</script>

<template>
    <div>
      <HeaderProfile :description="description" :username="username" :pseudo="pseudo"></HeaderProfile>
    </div>
    <div>
      <div v-if="tweet_available">
        <TweetList :tweets="user_tweets"></TweetList>
      </div>
      <div v-else>
        No tweet yet
      </div>
    </div>
    
    
</template>