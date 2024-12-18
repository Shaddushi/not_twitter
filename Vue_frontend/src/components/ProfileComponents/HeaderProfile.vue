<script setup>
    const props = defineProps({
        username: {
            String
        },
        description: {
            String
        },
        pseudo: {
            String
        },
        
    })




</script>


<template>
    <div> {{ pseudo }}</div>
    <div> @{{ username }}</div>
    <div> {{ description }}</div>
</template>