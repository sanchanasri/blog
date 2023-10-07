document.addEventListener('DOMContentLoaded', () => {
    const postTitles = document.querySelectorAll('.post-title');

    postTitles.forEach((title) => {
        title.addEventListener('click', () => {
            console.log('Post title clicked');
            const postElement = title;
            const post_id = postElement.getAttribute('data-post-id');
            const topic_id = postElement.getAttribute('data-topic-id');
            console.log('Post title clicked');
            fetch(`/topics/${topic_id}/posts/${post_id}/mark_as_read`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                },
            })
                .then((response) => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then((data) => {
                    if (data.status === 'success') {
                        postElement.querySelector('.unread').classList.remove('unread');
                        postElement.querySelector('.read').classList.add('read');
                    } else {
                        console.error('Server returned an error:', data.error);
                    }
                })
                .catch((error) => {
                    console.error('Fetch error:', error);
                });
        });
    });
});
