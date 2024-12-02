<script setup>
import {computed, defineProps} from "vue"

const props = defineProps(
  {
    users:{
      user_id: Number,
      user_name: String,
      user_description: String
    }
  })

const users = computed(() => props.users)
console.log(users.value)

</script>



<template>
    <div v-for="user in users">
      {{ user.user_name }}
    </div>
  </template>
  

  