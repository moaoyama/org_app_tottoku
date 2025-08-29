// app/javascript/custom/image_upload.js

export async function resizeAndUpload(file, form) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);

    reader.onload = (event) => {
      const img = new Image();
      img.src = event.target.result;

      img.onload = () => {
        const maxWidth = 1280;
        const maxHeight = 1280;
        let width = img.width;
        let height = img.height;

        if (width > height) {
          if (width > maxWidth) {
            height *= maxWidth / width;
            width = maxWidth;
          }
        } else {
          if (height > maxHeight) {
            width *= maxHeight / height;
            height = maxHeight;
          }
        }

        const canvas = document.createElement("canvas");
        canvas.width = width;
        canvas.height = height;
        const ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, width, height);

        canvas.toBlob(
          (blob) => {
            if (!blob) {
              reject(new Error("画像のBlob変換に失敗しました"));
              return;
            }

            const formData = new FormData(form);
            formData.delete("images[]");
            formData.append("images[]", blob, file.name);

            fetch(form.action, {
              method: "POST",
              body: formData,
              headers: {
                "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
              }
            })
              .then((response) => {
                if (response.ok) {
                  resolve("アップロード成功");
                } else {
                  reject("アップロード失敗");
                }
              })
              .catch((err) => reject(err));
          },
          "image/jpeg",
          0.8
        );
      };
    };
  });
}