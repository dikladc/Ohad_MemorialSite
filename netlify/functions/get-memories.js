// Netlify Function to fetch form submissions
// This allows us to display submitted memories on the page

exports.handler = async (event, context) => {
  // Only allow GET requests
  if (event.httpMethod !== 'GET') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' })
    };
  }

  try {
    // In production, this will fetch from Netlify's Forms API
    // For now, return a sample structure
    const memories = {
      submissions: [
        // Submissions will appear here after the form is submitted
        // The Netlify Forms API will provide them
      ]
    };

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify(memories)
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Failed to fetch memories' })
    };
  }
};
