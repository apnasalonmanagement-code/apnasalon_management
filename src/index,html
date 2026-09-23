export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    // Root → /shop/
    if (url.pathname === "/") {
      return Response.redirect(`${url.origin}/shop/`, 302);
    }

    // Management Flutter app
    if (url.pathname === "/shop" || url.pathname.startsWith("/shop/")) {
      const newUrl = new URL(request.url);

      // Remove /shop before requesting the Flutter asset
      newUrl.pathname =
        url.pathname.replace(/^\/shop/, "") || "/";

      return env.ASSETS.fetch(
        new Request(newUrl, request)
      );
    }

    return new Response("Not Found", {
      status: 404
    });
  }
};
